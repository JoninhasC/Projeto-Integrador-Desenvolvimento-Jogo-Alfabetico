extends Label

var palavra : String 
var caracteres_da_palavra : Array 

func _ready():
	custom_minimum_size = Vector2(300, 40)  # Defina o tamanho mínimo para acomodar o texto	
	pegar_palavra(Global.nivel, Global.modalidade)
	print(palavra)
	caracteres(palavra)
	print(caracteres_da_palavra)
	print("%s nivel %s modalidade", Global.nivel, Global.modalidade)
	alfabeto_sem_letras_da_palavra(Global.caracteres_do_alfabeto_sem_palavra)
	#printar_alfabeto_sem_palavra(caracteres_do_alfabeto_sem_palavra)
	criar_labels()

func caracteres(palavra):
	caracteres_da_palavra = palavra.split("")	
	
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

func pegar_palavra(nivel, modalidade):
	for buscar_nivel in Global.nivel_modalidade:
		if nivel == buscar_nivel["nivel"]:
			print("Nível encontrado: ", nivel)
			var categorias = buscar_nivel["categorias"]
			if categorias.has(modalidade):
				var palavras = categorias[modalidade]
				print("Modalidade encontrada: ", modalidade)
				print("Palavras: ", palavras)
				palavra = palavras[1]
				print(palavra)
			
	
func atualiza_cor_do_caractere_na_posicao(indice):
	Global.labels[indice].modulate = Color(Global.cores[0])  # Aplica a cor específica ao índice

func alfabeto_sem_letras_da_palavra(string):
	var copiar_string = string.duplicate() 
	var letra
	for letras in caracteres_da_palavra:
		if letra in copiar_string:
			copiar_string.erase(letra)
		string.clear()
		string.append_array(copiar_string)
					
func printar_alfabeto_sem_palavra(string):
	for a in range(string.size()):
		print("A letra do alfabeto é ", string[a])
