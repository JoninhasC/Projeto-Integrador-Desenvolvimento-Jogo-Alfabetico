extends Label

var palavra : String = "ABCDE"
var caracteres_da_palavra : Array = palavra.split("")	

func _ready():
	custom_minimum_size = Vector2(300, 40)  # Defina o tamanho mínimo para acomodar o texto	
	alfabeto_sem_letras_da_palavra(Global.caracteres_do_alfabeto_sem_palavra)
	#printar_alfabeto_sem_palavra(caracteres_do_alfabeto_sem_palavra)
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

func alfabeto_sem_letras_da_palavra(string):
	var resize = 0
	while resize < caracteres_da_palavra.size():
		var auxiliar = string.slice(0, string.size())		
		for a in range(caracteres_da_palavra.size()):
			for b in range(auxiliar.size()):
				if caracteres_da_palavra[a] == auxiliar[b]:
					string.remove_at(b)
					resize += 1
					break
				break
					
func printar_alfabeto_sem_palavra(string):
	for a in range(string.size()):
		print("A letra do alfabeto é ", string[a])
