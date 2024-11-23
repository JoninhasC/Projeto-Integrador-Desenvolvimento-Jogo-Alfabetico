extends Control



func _ready() -> void:
	for _button in get_tree().get_nodes_in_group("modalidades_categorias"):
		_button.pressed.connect(_on_button_pressed.bind(_button))

func _on_button_pressed(_button : Button)-> void:
	match _button.name:
		"animais":
			Global.modalidade = "animais"
			get_tree().change_scene_to_file("res://cenas/main.tscn")
		"frutas":
			Global.modalidade = "frutas"
			get_tree().change_scene_to_file("res://cenas/main.tscn")
		"objetos":
			Global.modalidade = "objetos"
			get_tree().change_scene_to_file("res://cenas/main.tscn")
