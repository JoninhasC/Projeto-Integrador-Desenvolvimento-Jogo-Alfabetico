extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	mostrar_volume()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mostrar_volume()
	
func mostrar_volume():
	self.text = String("VOLUME : ") + str(Global.volume)
