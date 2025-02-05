extends Node2D


# Carrega a cena da letra que será usada para criar instâncias
var Letter = preload("res://cenas/letter.tscn")

# Função chamada quando o nó é inicializado
func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	# Configura a interface do usuário
	setup_ui()
	# Inicia a primeira palavra do jogo
	start_new_word()
	
	# Conecta o sinal de mudança de vidas à função correspondente
	GameManager.life_changed.connect(_on_life_changed)
	# Conecta o sinal de palavra completa à função correspondente
	GameManager.word_completed.connect(_on_word_completed)

# Configura elementos iniciais da interface
func setup_ui():
	# Atualiza o display de vidas com o valor inicial
	update_lives_display(GameManager.lives)

# Função para atualizar a exibição das vidas
func update_lives_display(lives: int):
	# Obtém todos os corações no HeartContainer
	var hearts = $CanvasLayer/HeartContainer.get_children()
	
	# Itera sobre os corações e mostra ou esconde com base nas vidas
	for i in range(hearts.size()):
		if i < lives:
			hearts[i].visible = true  # Mostra o coração
		else:
			hearts[i].visible = false  # Esconde o coração

# Inicia uma nova palavra no jogo
func start_new_word():
	# Loop para remover todas as letras antigas da cena
	for child in get_children():
		# Se o nó filho pertence ao grupo "letter"
		if child.is_in_group("letter"):
			# Remove a letra da cena
			child.queue_free()
	
	# Loop para limpar os placeholders da palavra anterior
	for child in $CanvasLayer/ProgressLabel.get_children():
		# Remove cada placeholder
		child.queue_free()
	
	# Obtém uma nova palavra aleatória do GameManager
	GameManager.current_word = GameManager.get_random_word()
	# Obtém uma nova cor aleatória do GameManager
	GameManager.current_color = GameManager.get_random_color()
	
	# Atualiza o label com a nova palavra
	$CanvasLayer/WordLabel.text = GameManager.current_word
	# Cria os placeholders para a nova palavra
	create_letter_placeholders()
	# Gera as letras para a nova palavra
	generate_letters(GameManager.current_word, GameManager.current_color)

# Cria os placeholders (underlines) para cada letra da palavra
func create_letter_placeholders():
	# Define a margem esquerda para os placeholders
	var start_x = 20
	# Define a margem superior para os placeholders
	var start_y = 20
	
	# Loop para criar um placeholder para cada letra da palavra atual
	for i in range(GameManager.current_word.length()):
		# Cria um novo label
		var placeholder = Label.new()
		# Define o texto como underline
		placeholder.text = "_"
		# Define o tamanho da fonte
		placeholder.add_theme_font_size_override("font_size", 50)
		# Calcula e define a posição do placeholder
		placeholder.position = Vector2(start_x + (i * GameManager.LETTER_SPACING), start_y)
		# Adiciona o placeholder ao nó ProgressLabel
		$CanvasLayer/ProgressLabel.add_child(placeholder)

# Função chamada quando uma letra é coletada
func _on_letter_collected(letter_info):
	# Verifica se a letra coletada é incorreta
	if not letter_info.is_correct:
		# Se perder vida e não tiver mais vidas, chama game over
		if GameManager.lose_life():
			game_over()
		return
	
	# Procura a posição da letra na palavra atual
	var letter_index = GameManager.current_word.find(letter_info.letter)
	# Se encontrou a letra na palavra
	if letter_index != -1:
		# Obtém o placeholder correspondente à posição da letra
		var placeholder = $CanvasLayer/ProgressLabel.get_child(letter_index)
		# Atualiza o texto do placeholder com a letra
		placeholder.text = letter_info.letter
		# Muda a cor do texto para verde
		placeholder.add_theme_color_override("font_color", Color.GREEN)
		
		# Adiciona a letra à lista de letras coletadas
		GameManager.collected_letters.append(letter_info.letter)
		
		# Verifica se todas as letras foram coletadas
		if GameManager.collected_letters.size() == GameManager.current_word.length():
			# Adiciona pontos pela palavra completa
			GameManager.add_score(100)
			# Inicia uma nova palavra
			start_new_word()

# Função chamada quando o número de vidas muda
func _on_life_changed(new_lives: int):
	# Atualiza o display com o novo número de vidas
	update_lives_display(new_lives)

# Função chamada quando o jogador perde todas as vidas
func game_over():
	# Reseta o número de vidas
	GameManager.reset_lives()
	# Limpa a lista de letras coletadas
	GameManager.collected_letters.clear()
	# Limpa as posições registradas
	GameManager.clear_positions()
	# Recarrega a cena atual
	get_tree().reload_current_scene()

# Função chamada quando uma palavra é completada
func _on_word_completed():
	# Inicia uma nova palavra
	start_new_word()

# Gera as letras para a palavra atual
func generate_letters(word: String, color: String):
	# Obtém referência ao TileMap
	var tilemap = $TileMap
	# Obtém os limites usados do TileMap
	var map_limits = tilemap.get_used_rect()
	# Obtém o tamanho dos tiles
	var tile_size = tilemap.cell_quadrant_size
	# Calcula a largura total do mapa
	var map_width = map_limits.size.x * tile_size
	
	# Gera as letras necessárias para a palavra
	for letter in word:
		# Spawna cada letra da palavra
		spawn_letter(letter, color, true)
	
	# String com todas as letras do alfabeto
	var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	# Gera 5 letras extras
	for i in range(5):
		# Escolhe uma letra aleatória do alfabeto
		var extra_letter = alphabet[randi() % alphabet.length()]
		# Enquanto a letra escolhida existir na palavra, escolhe outra
		while word.find(extra_letter) != -1:
			extra_letter = alphabet[randi() % alphabet.length()]
		# Spawna a letra extra
		spawn_letter(extra_letter, color, false)

# Função para criar uma nova letra no cenário
func spawn_letter(letter: String, color: String, is_correct: bool):
	# Obtém referência ao TileMap
	var tilemap = $TileMap
	# Obtém os limites usados do TileMap
	var map_limits = tilemap.get_used_rect()
	# Obtém o tamanho dos tiles
	var tile_size = tilemap.cell_quadrant_size
	# Calcula a largura total do mapa
	var map_width = map_limits.size.x * tile_size
	# Define a largura da zona segura inicial
	var safe_zone_width = 200
	
	# Variáveis para controle do posicionamento
	var position_found = false
	var random_position = Vector2.ZERO
	var attempts = 0
	var max_attempts = 50
	
	# Tenta encontrar uma posição válida para a letra
	while !position_found and attempts < max_attempts:
		# Gera uma posição X aleatória após a zona segura
		var x_position = randf_range(safe_zone_width, map_width - 100)
		# Define a posição Y acima da tela
		random_position = Vector2(x_position, -50)
		
		# Verifica se a posição é válida
		if GameManager.is_position_valid(random_position):
			position_found = true
		
		# Incrementa o número de tentativas
		attempts += 1
	
	# Registra a posição usada
	GameManager.register_position(random_position)
	
	# Cria uma nova instância da letra
	var letter_instance = Letter.instantiate()
	# Configura a letra com os parâmetros fornecidos
	letter_instance.setup(letter, color, is_correct)
	# Define a posição da letra
	letter_instance.position = random_position
	# Conecta o sinal de coleta à função correspondente
	letter_instance.connect("letter_collected", Callable(self, "_on_letter_collected"))
	# Adiciona a letra ao grupo "letter"
	letter_instance.add_to_group("letter")
	# Adiciona a letra à cena
	add_child(letter_instance)
