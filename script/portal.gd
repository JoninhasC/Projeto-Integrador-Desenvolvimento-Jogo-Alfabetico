extends Area2D  # Classe base para áreas de detecção de colisão ou interação.

# Variável exportada que permite configurar o caminho da próxima cena diretamente no editor Godot.
@export var nextScene= ""  # A variável para o caminho da cena a ser carregada.

# Função chamada quando um corpo entra na área da Area2D.
func _on_body_entered(body):
	# Verifica se o corpo que entrou na área pertence ao grupo "player".
	if body.is_in_group("player"):
		# Verifica se o caminho da cena foi configurado.
			get_tree().change_scene_to_file(nextScene)  # Altera para a cena se o caminho for válido.
			
