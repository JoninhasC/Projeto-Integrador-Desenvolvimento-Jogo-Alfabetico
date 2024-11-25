extends Control


func _ready() -> void:
	for _button in get_tree().get_nodes_in_group("botoes_gameover"):
		_button.pressed.connect(_on_button_pressed.bind(_button))

func _on_button_pressed(_button : Button)-> void:
	Global.vida = 3
	match _button.name:
		"reiniciar_nivel":
			get_tree().change_scene_to_file("res://cenas/main.tscn")
		"trocar_modalidade":
			get_tree().change_scene_to_file("res://cenas/modalidade.tscn")
		"reiniciar_jogo":
			get_tree().change_scene_to_file("res://cenas/niveis.tscn")
		"sair": 
			get_tree().quit()

