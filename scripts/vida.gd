extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	mostrar_vidas()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mostrar_vidas()

func mostrar_vidas():
	self.text = String("VIDAS: ") + str(Global.vida)
