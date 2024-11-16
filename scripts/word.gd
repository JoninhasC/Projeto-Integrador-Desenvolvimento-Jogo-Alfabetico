extends Label

var palavra : String = "ABCDE"
var caracteres : Array = palavra.split("")	

func _ready():
	custom_minimum_size = Vector2(300, 40)  # Defina o tamanho mínimo para acomodar o texto	
	criar_labels()
		
func criar_labels():
	for child in get_children(): #remover labels existentes
		child.queue_free()
	Global.labels.clear()	
	for i in range(palavra.length()):
		var label = Label.new()
		label.text = palavra[i]
		label.modulate = Global.cores[1]
		add_child(label)
		Global.labels.append(label)
		label.set_position(Vector2(i * 20, 0))

func atualiza_cor_do_caractere_na_posicao(indice):
	Global.labels[indice].modulate = Color(Global.cores[0])  # Aplica a cor específica ao índice




