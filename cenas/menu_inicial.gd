extends Node2D

var somEnabled = true

func _on_inicia_button_pressed() -> void:
	var text = $LineEdit.text.strip_edges()
	
	if text.is_empty():
		$Label.text = "Por favor, digite seu nome para iniciarmos"
		$Label.show()  # Garante que o Label fique visível
	else:
		print("Bem-vindo, " + text)
		get_tree().change_scene_to_file("res://cenas/world.tscn")


func _on_som_button_pressed() -> void:
	somEnabled = !somEnabled
	$BotaoSom.self_modulate.a = 1 if somEnabled else 0.2
