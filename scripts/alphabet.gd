extends Node2D

#O ALFABETO É RESPONSÁVEL POR TODA ORGANIZAÇÃO DE TODAS AS LETRAS
@onready var letras := [$A, $B, $C, $D, $E, $F, $G, $H, $I, $J, $K, $L, $M, $N, $O, $P, $Q, $R, $S, $T, $U, $V, $W, $X, $Y, $Z]
@onready var sprite = $Sprite2D
var GRAVIDADE = ProjectSettings.get_setting("physics/2d/default_gravity")
var indice = 0
func _ready():
	randomize() # randomiza o aparecimento das letras na tela

	for letra in letras:		
		carregar_textura_letra(indice, letra)
		ajustar_tamanho_da_textura(indice, letra)
		var random_position = Vector2( randf_range(0, get_viewport_rect().size.x), randf_range(0,  get_viewport_rect().size.y)) #coloca as letras em uma posição conforme as especificações da tela 
		letra.position = random_position
		indice += 1
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Cria uma cópia da lista para iterar, para evitar erros ao remover letras
	for letra in letras.duplicate():
		if is_instance_valid(letra):
			letra.velocity.y += GRAVIDADE * delta
			letra.move_and_slide()
		else:
			letras.erase(letra)  # Remove da lista caso a letra já tenha sido liberada


func carregar_textura_letra(indice, letra):
	# Pega a cor atual do Global (0 = azul, 1 = cinza_claro, ...)
	var cor_selecionada = Global.cores_path[Global.cor_atual]
	# Constrói o caminho para a textura usando a letra definida no inspetor
	var caminho_textura = "res://sprites/Letters/%s/letter_%s.png" % [cor_selecionada, Global.caracteres_alfabeto[indice]]
	# Carrega e aplica a textura
	var textura = load(caminho_textura)
	sprite = letra.get_node("Sprite2D")
	sprite.texture = textura

func ajustar_tamanho_da_textura(indice, letra):
	var sprite = letra.get_node("Sprite2D")
	var hitbox = letra.get_node("hitbox/CollisionShape2D")
	if sprite.texture:
		sprite.scale = hitbox.shape.get_size()  / sprite.texture.get_size()
		sprite.position =  hitbox.shape.get_size() /20
	
