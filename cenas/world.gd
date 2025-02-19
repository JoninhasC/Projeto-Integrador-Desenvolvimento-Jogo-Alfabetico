extends Node2D

# Carrega a cena da letra que será usada para criar instâncias
var Letter = preload("res://cenas/letter.tscn")
var words_completed = 0 # Contador de palavras completadas
const WORDS_PER_WORLD = 1 # Numero de palavras para completar cada mundo

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
	# Limpa as letras coletadas
	GameManager.collected_letters.clear()
	# Loop para remover todas as letras antigas da cena
	for child in get_children():
		if child.is_in_group("letter"):
			child.queue_free()
	# Loop para limpar os placeholders da palavra anterior
	for child in $CanvasLayer/ProgressLabel.get_children():
		child.queue_free()
	# Obtém uma nova palavra aleatória do GameManager
	GameManager.current_word = GameManager.get_random_word()
	GameManager.current_color = GameManager.get_random_color()
	# Atualiza o label com a nova palavra
	$CanvasLayer/WordLabel.text = GameManager.current_word
	# Cria os placeholders para a nova palavra
	create_letter_placeholders()
	# Gera as letras para a nova palavra
	generate_letters(GameManager.current_word, GameManager.current_color)

# Cria os placeholders (underlines) para cada letra da palavra
func create_letter_placeholders():
	# Limpa os placeholders antigos
	for child in $CanvasLayer/ProgressLabel.get_children():
		child.queue_free()
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
	if not letter_info.is_correct:
		if GameManager.lose_life():
			game_over()
		return
	# Encontra o índice da letra coletada na palavra atual
	var letter_index = GameManager.current_word.find(letter_info.letter)
	if letter_index != -1:
		# Atualiza o placeholder correspondente no ProgressLabel
		var placeholder = $CanvasLayer/ProgressLabel.get_child(letter_index)
		placeholder.text = letter_info.letter  # Coloca a letra no placeholder
		placeholder.add_theme_color_override("font_color", Color.GREEN)  # Muda a cor para verde
	# Adiciona a letra coletada ao array de letras coletadas
	GameManager.collected_letters.append(letter_info.letter)
	# Verifica se todas as letras da palavra foram coletadas
	if GameManager.collected_letters.size() == GameManager.current_word.length():
		GameManager.add_score(100)  # Adiciona pontos por completar a palavra
		words_completed += 1  # Incrementa o contador de palavras completadas
		# Verifica se o número de palavras completadas atingiu o limite para o mundo atual
		if words_completed >= WORDS_PER_WORLD:
			advance_world()  # Avança para o próximo mundo
		else:
			start_new_word()  # Inicia uma nova palavra no mesmo mundo

# Função chamada quando o número de vidas muda
func _on_life_changed(new_lives: int):
	# Atualiza o display com o novo número de vidas
	update_lives_display(new_lives)

# Função chamada quando o jogador perde todas as vidas
func game_over():
	GameManager.reset_game()  # Reseta todo o progresso
	get_tree().reload_current_scene()

# Função chamada quando uma palavra é completada
func _on_word_completed():
	words_completed += 1  # Incrementa o contador de palavras completadas
	# Verifica se o número de palavras completadas atingiu o limite para o mundo atual
	if words_completed == WORDS_PER_WORLD:
		advance_world()  # Avança para o próximo mundo
	else:
		start_new_word()  # Inicia uma nova palavra no mesmo mundo

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


# Função para avançar para o próximo mundo
func advance_world():
	# Incrementa o índice do mundo atual no GameManager
	GameManager.current_world_index += 1
	# Verifica se há um próximo mundo para carregar
	if GameManager.current_world_index < GameManager.WORLD_SCENES.size():
		var next_world = GameManager.WORLD_SCENES[GameManager.current_world_index]
		print("Avançando para o próximo mundo: ", next_world)
		get_tree().change_scene_to_file(next_world)  # Carrega a próxima cena
	else:
		# Se não houver mais mundos, o jogo é concluído
		print("Todos os mundos foram completados!")
		game_completed()

# Função para quando o jogo for completado
func game_completed():
	GameManager.reset_game()
	get_tree().change_scene_to_file("res://cenas/menu_inicial.tscn")

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
