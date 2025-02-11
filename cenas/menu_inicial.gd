extends Node2D

var somEnabled = true
@export var som: Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_inicia_button_pressed() -> void:
	var text = $LineEdit.text
	if (text):
		print("Bem vindo " + text)
		get_tree().change_scene_to_file("res://cenas/world.tscn")
	else:
		print("Por favor, digite seu nome para iniciarmos")
		$Label.text = "Por favor, digite seu nome para iniciarmos"

@onready var menuInicial = $BotaoSom/menu_incial as AudioStreamPlayer


func _on_som_button_pressed() -> void:
	somEnabled = !somEnabled
	if (somEnabled):
		som.stream_paused = false
		$BotaoSom.self_modulate.a = 1
	else:
		som.stream_paused = true
		$BotaoSom.self_modulate.a = 0.2
