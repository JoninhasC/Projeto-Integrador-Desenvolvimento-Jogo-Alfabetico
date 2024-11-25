extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	mostrar_total_de_acertos()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mostrar_total_de_acertos()

func mostrar_total_de_acertos():
	self.text = String("ACERTOS TOTAIS: ") + str(Global.acertos)
