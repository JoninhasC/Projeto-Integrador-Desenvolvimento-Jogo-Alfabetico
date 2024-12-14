extends CharacterBody2D

# Definindo constantes para a velocidade de movimento e velocidade de pulo
const SPEED = 300.0  # A velocidade horizontal de movimento do personagem.
const JUMP_VELOCITY = -700.0  # A velocidade do pulo (valor negativo para direcionar para cima).
const ACTION_JUMP = "ui_up"  # A ação associada ao pulo (geralmente a tecla de cima ou espaço).
const ACTION_LEFT = "ui_left"  # A ação para mover para a esquerda (geralmente a tecla de seta para a esquerda).
const ACTION_RIGHT = "ui_right"  # A ação para mover para a direita (geralmente a tecla de seta para a direita).

# Variáveis para controlar a física
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")  # Obtém a gravidade do projeto.
var is_jumping = false  # Variável para controlar se o personagem está no estado de pulo.

# A referência ao sprite de animação do personagem
@onready var animacao := $Animate as AnimatedSprite2D  # Referência ao nó de animação para controlar as animações.

# Função principal de atualização a cada frame da física do jogo
func _physics_process(delta):
	# Aplica a gravidade ao personagem quando ele não está no chão
	if not is_on_floor():  # Verifica se o personagem não está no chão (no ar).
		velocity.y += gravity * delta  # Aplica a gravidade, alterando a velocidade vertical.

	# Verifica se o botão de pulo foi pressionado e o personagem está no chão
	if Input.is_action_just_pressed(ACTION_JUMP) and is_on_floor():  # Se o jogador pressionou o botão de pulo e o personagem está no chão.
		velocity.y = JUMP_VELOCITY  # Define a velocidade de pulo (para cima).
		is_jumping = true  # Marca o estado como "pulando".
		animacao.play("pulo")  # Toca a animação de pulo.

	# Verifica se o personagem aterrissou após pular
	if is_on_floor():  # Se o personagem está no chão (aterrissado).
		is_jumping = false  # Marca que o personagem não está mais no ar.

	# Controle de movimento lateral (esquerda/direita).
	var direction = Input.get_axis(ACTION_LEFT, ACTION_RIGHT)  # Obtém a direção do movimento: -1 para esquerda, 1 para direita e 0 para parado.
	if direction != 0 and not is_jumping:  # Se o personagem está se movendo horizontalmente e não está pulando.
		velocity.x = direction * SPEED  # Ajusta a velocidade horizontal com base na direção (direita ou esquerda).
		animacao.scale.x = direction  # Inverte a direção do sprite horizontalmente (para a esquerda ou direita).
		if animacao.animation != "movimentacao":  # Se a animação não está em "movimentação" (correndo ou andando).
			animacao.play("movimentacao")  # Reproduz a animação de movimento (correr ou andar).
	elif is_on_floor() and direction == 0:  # Se o personagem está parado no chão.
		velocity.x = lerp(velocity.x, 0.0, 5 * delta)  # Suaviza a desaceleração do movimento até parar o personagem.
		if not is_jumping and animacao.animation != "idle":  # Se não estiver pulando e a animação não for de "idle".
			animacao.play("idle")  # Reproduz a animação de "idle" (parado).

	# Caso o personagem esteja no ar, a animação de pulo deve ser mantida.
	if is_jumping:  # Se o personagem estiver no ar.
		if animacao.animation != "pulo":  # Se a animação não for de "pulo".
			animacao.play("pulo")  # Toca a animação de pulo.

	# O move_and_slide() lida com a movimentação e colisões, já considerando a velocidade do personagem.
	move_and_slide()  # O CharacterBody2D lida com a movimentação automaticamente, considerando as colisões.
