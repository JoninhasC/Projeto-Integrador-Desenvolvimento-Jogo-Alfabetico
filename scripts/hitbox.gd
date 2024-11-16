extends Area2D

var colisao
@onready var script_word = load("res://cenas/word.tscn").instantiate()

func _ready():	
	self.monitoring = true #não pode retirar, pois sem essa função não tem como monitorar as colisões
	
func _on_body_entered(body) -> void:	
	colisao = self.get_parent().name
	verifica_se_letra_colidida_esta_na_word(colisao)
	owner.queue_free()
	return 

func verifica_se_letra_colidida_esta_na_word(colisao):
	for posicao_indice in range(script_word.caracteres.size()):
		if script_word.caracteres[posicao_indice] == colisao:
			script_word.atualiza_cor_do_caractere_na_posicao(posicao_indice)


