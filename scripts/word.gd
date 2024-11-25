extends Label



func _ready():
	custom_minimum_size = Vector2(300, 40)  # Defina o tamanho mínimo para acomodar o texto	
	selecionar_palavra_do_dicionario(Global.nivel, Global.modalidade)
	separar_os_caracteres_da_palavra_selecionada(Global.palavra)
	deixar_todas_as_letras_em_maiusculo(Global.caracteres_da_palavra)
	remover_letras_que_estao_na_palavra_escolhida_e_no_alfabeto(Global.caracteres_do_alfabeto_sem_palavra)
	#printar_alfabeto_sem_palavra(Global.caracteres_do_alfabeto_sem_palavra)
	criar_labels()


func separar_os_caracteres_da_palavra_selecionada(palavra):
	Global.caracteres_da_palavra = palavra.split("")
	
func deixar_todas_as_letras_em_maiusculo(caracteres):
	var todos_os_caracteres_em_maiusculo = []
	for letra in caracteres:
		todos_os_caracteres_em_maiusculo.append(letra.to_upper())
	caracteres.clear()
	caracteres.append_array(todos_os_caracteres_em_maiusculo)  
		
func criar_labels():
	for child in get_children(): #remover labels existentes
		child.queue_free()
	Global.labels.clear()	
	for i in range(Global.palavra.length()):
		var label = Label.new()
		label.text = Global.caracteres_da_palavra[i]
		label.modulate = Global.cores[1]
		add_child(label)
		Global.labels.append(label)
		label.set_position(Vector2(i * 20, 0))

func selecionar_palavra_do_dicionario(nivel, modalidade):
	for buscar_nivel in Global.nivel_modalidade:
		if nivel == buscar_nivel["nivel"]:
			var categorias = buscar_nivel["categorias"]
			if categorias.has(modalidade):
				var palavras = categorias[modalidade]
				Global.palavra = palavras[1]
				
func atualiza_cor_do_caractere_na_posicao(indice):
	Global.labels[indice].modulate = Color(Global.cores[0])  # Aplica a cor específica ao índice
	
func remover_letras_que_estao_na_palavra_escolhida_e_no_alfabeto(string):
	var copia_string = string.duplicate()
	for letra in Global.caracteres_da_palavra:
		if letra in copia_string:
			copia_string.erase(letra)
	string.clear()
	string.append_array(copia_string)
	
					
func printar_alfabeto_sem_palavra(string):
	for a in range(string.size()):
		print("A letra do alfabeto é ", string[a])
