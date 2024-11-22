extends CharacterBody2D


# Esta linha faz a variável aparecer no inspetor
@export var letra: String = "B" 

@onready var hitbox = $Area2D/CollisionShape2D
@onready var sprite = $Sprite2D

# Lista de cores disponíveis nas pastas
var cores = ["azul", "cinza_claro", "cinza_escuro", "madeira", "marrom", "yellow"]

func _ready():
	carregar_textura_letra()
	ajustar_hitbox()

func carregar_textura_letra():
	# Pega a cor atual do Global (0 = azul, 1 = cinza_claro, ...)
	var cor_selecionada = cores[Global.cor_atual]
	
	# Constrói o caminho para a textura usando a letra definida no inspetor
	var caminho_textura = "res://sprites/Letters/%s/%s.png" % [cor_selecionada, letra]
	
	# Carrega e aplica a textura
	var textura = load(caminho_textura)
	if textura:
		sprite.texture = textura
	else:
		print("Erro ao carregar textura para letra ", letra, " na cor ", cor_selecionada)
		print("Caminho tentado: ", caminho_textura)

func ajustar_hitbox():
	if sprite.texture:
		var sprite_size = sprite.texture.get_size() * sprite.scale
		var shape = RectangleShape2D.new()
		shape.size = sprite_size
		hitbox.shape = shape
		hitbox.position = sprite_size / 2
