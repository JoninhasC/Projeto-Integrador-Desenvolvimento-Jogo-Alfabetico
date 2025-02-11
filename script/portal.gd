extends Area2D  # Classe base para áreas de detecção de colisão ou interação.

# Variável exportada que permite configurar o caminho da próxima cena diretamente no editor Godot.
@export var nextScene: String = ""  # A variável para o caminho da cena a ser carregada.

# Função chamada quando um corpo entra na área da Area2D.
func _on_body_entered(body):
	# Verifica se o corpo que entrou na área pertence ao grupo "player".
	if body.is_in_group("player"):
		# Verifica se o caminho da cena foi configurado.
		if nextScene != "":
			# Exibe o caminho da cena no console para depuração.
			print("Caminho da cena: ", nextScene)
			
			# Tenta carregar a cena usando o caminho configurado.
			var scene_exists = ResourceLoader.exists(nextScene)  # Verifica se o arquivo da cena existe.
			if scene_exists:
				get_tree().change_scene_to_file(nextScene)  # Altera para a cena se o caminho for válido.
			else:
				print("Erro: Cena não encontrada. Verifique o caminho.")
		else:
			print("Erro: Caminho da cena não especificado.")
