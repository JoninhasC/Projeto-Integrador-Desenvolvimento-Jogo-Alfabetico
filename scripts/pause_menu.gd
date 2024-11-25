extends CanvasLayer

@onready var btn_retomar = $menu_holder/btn_retomar

func _ready():
	visible = false

func _process(delta):
	pass

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"): #verifica se a tecla ESC foi pressionada
		visible = true #torna visivel o menu
		get_tree().paused = true
		btn_retomar.grab_focus()

func _on_btn_retomar_pressed():
	get_tree().paused = false
	visible = false

func _on_btn_sair_pressed():
	get_tree().quit()
