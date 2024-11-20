extends Area2D

var contador = 0
var colisao
@onready var script_word = load("res://cenas/word.tscn").instantiate()

func _ready():	
	self.monitoring = true #não pode retirar, pois sem essa função não tem como monitorar as colisões
	
func _on_body_entered(body) -> void:	
	colisao = self.get_parent().name
	print("COLISÃO NOME ", self.get_parent().name)
	verifica_se_letra_colidida_esta_na_word(colisao)
	verifica_se_letra_colidida_nao_esta_na_word(colisao)
	#script_word.printar_alfabeto_sem_palavra(Global.caracteres_do_alfabeto_sem_palavra)
	owner.queue_free()
	return 

func verifica_se_letra_colidida_esta_na_word(colisao):
	for posicao_indice in range(script_word.caracteres_da_palavra.size()):
		if script_word.caracteres_da_palavra[posicao_indice] == colisao:
			script_word.atualiza_cor_do_caractere_na_posicao(posicao_indice)

func verifica_se_letra_colidida_nao_esta_na_word(colisao):
	for posicao_indice in range(Global.caracteres_do_alfabeto_sem_palavra.size()):
		if Global.caracteres_do_alfabeto_sem_palavra[posicao_indice] == colisao:
			Global.vida -= 1
			print("vidas é", Global.vida)
