extends Control



func _ready() -> void:
	for _button in get_tree().get_nodes_in_group("botoes_dos_niveis"):
		_button.pressed.connect(_on_button_pressed.bind(_button))

func _on_button_pressed(_button : Button)-> void:
	match _button.name:
		"facil":
			Global.nivel = "facil"
			get_tree().change_scene_to_file("res://cenas/modalidade.tscn")
		"intermediario":
			Global.nivel = "intermediario"
			get_tree().change_scene_to_file("res://cenas/modalidade.tscn")
		"dificil":
			Global.nivel = "dificil"
			get_tree().change_scene_to_file("res://cenas/modalidade.tscn")

