extends Control

func _ready() -> void:
	for _button in get_tree().get_nodes_in_group("botoes_configuracao"):
		_button.pressed.connect(_on_button_pressed.bind(_button))
		
func _on_button_pressed(_button : Button)-> void:
	match _button.name:
		"menos":
			Global.volume -= 1
			
		"mais":
			Global.volume += 1
			
		"mudo":
			Global.volume = 0
		"sair":
			get_tree().quit()
