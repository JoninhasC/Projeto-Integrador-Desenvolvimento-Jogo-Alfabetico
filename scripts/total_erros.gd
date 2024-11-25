extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	mostrar_total_de_erros()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mostrar_total_de_erros()
	
func mostrar_total_de_erros():
	self.text = String("ERROS TOTAIS: ") + str(Global.erros)
