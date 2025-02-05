extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("menu_pause"):
		if !get_tree().paused:
			pause()
		else:
			resume()


func pause():
	get_tree().paused = true
	self.visible = true
	

func resume():
	get_tree().paused = false
	self.visible = false


func _on_resume_button_pressed() -> void:
	resume()


func _on_quit_button_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://cenas/menu_inicial.tscn")
