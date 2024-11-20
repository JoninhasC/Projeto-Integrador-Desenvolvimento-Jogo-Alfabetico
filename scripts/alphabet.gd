extends Node2D

#O ALFABETO É RESPONSÁVEL POR TODA ORGANIZAÇÃO DE TODAS AS LETRAS
@onready var letras := [$A, $B, $C, $D, $E, $F, $G, $H, $I, $J, $K, $L, $M, $N, $O, $P, $Q, $R, $S, $T, $U, $V, $W, $X, $Y, $Z]
var cor = 0

var GRAVIDADE = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	randomize() # randomiza o aparecimento das letras na tela

	for letra in letras:
		var sprite = letra.get_node(NodePath(Global.cor_do_sprite[cor])) as Sprite2D
		var random_position = Vector2( randf_range(0, get_viewport_rect().size.x), randf_range(0,  get_viewport_rect().size.y)) #coloca as letras em uma posição conforme as especificações da tela 
		letra.position = random_position
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Cria uma cópia da lista para iterar, para evitar erros ao remover letras
	for letra in letras.duplicate():
		if is_instance_valid(letra):
			letra.velocity.y += GRAVIDADE * delta
			letra.move_and_slide()
		else:
			letras.erase(letra)  # Remove da lista caso a letra já tenha sido liberada
