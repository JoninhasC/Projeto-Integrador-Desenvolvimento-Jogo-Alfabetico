extends Node

const WORDS = ["RATO", "GIRAFA", "JOGO", "HEROI", "GATO"]        # Lista de palavras que podem aparecer no jogo
const COLORS = ["amarelo", "azul", "cinza_claro", "cinza_escuro", "madeira", "marrom"]    # Lista de cores disponíveis para as letras
const MIN_DISTANCE = 100        # Define a distância mínima que deve haver entre as letras ao spawnar
const LETTER_SPACING = 100      # Define o espaçamento entre os placeholders das letras no topo da tela
const WORLD_SCENES = ["res://cenas/world.tscn", "res://cenas/world2.tscn", "res://cenas/world3.tscn", "res://cenas/world4.tscn"
, "res://cenas/world5.tscn", "res://cenas/world6.tscn", "res://cenas/world7.tscn", "res://cenas/world8.tscn", "res://cenas/world9.tscn"
, "res://cenas/world10.tscn"]

var current_word = ""          # Armazena a palavra atual que o jogador precisa completar
var current_color = ""         # Armazena a cor atual das letras
var lives = 3                  # Número de vidas do jogador
var score = 0                  # Pontuação do jogador
var collected_letters = []     # Array que armazena as letras já coletadas da palavra atual
var used_positions = []        # Array que armazena as posições já utilizadas para spawnar letras
var current_world_index = 0    # Indice do mundo atual

signal life_changed(new_lives) # Sinal emitido quando o número de vidas muda
signal score_changed(new_score)# Sinal emitido quando a pontuação muda
signal word_completed         # Sinal emitido quando uma palavra é completada
signal world_completed        # Sinal emitido quando um mundo é completo


# Nova função para avançar para o próximo mundo
func advance_to_next_world():
	current_world_index += 1
	if current_world_index < WORLD_SCENES.size():
		return WORLD_SCENES[current_world_index]
	return ""  # Retorna string vazia se não houver mais mundos

func reset_game_progress():
	current_world_index = 0
	reset_game()

func _ready():
	randomize()               # Inicializa o gerador de números aleatórios


func get_random_word() -> String:
	return WORDS[randi() % WORDS.size()]    # Escolhe e retorna uma palavra aleatória


func get_random_color() -> String:
	return COLORS[randi() % COLORS.size()]  # Escolhe e retorna uma cor aleatória


func reset_game():
	lives = 3                 # Restaura o número de vidas para 3
	score = 0                 # Zera a pontuação
	collected_letters.clear() # Limpa o array de letras coletadas
	used_positions.clear()    # Limpa as posições usadas
	current_world_index = 0
	emit_signal("life_changed", lives)    # Emite sinal informando mudança nas vidas
	emit_signal("score_changed", score)   # Emite sinal informando mudança na pontuação


func lose_life():
	lives -= 1               # Reduz uma vida
	emit_signal("life_changed", lives)    # Emite sinal informando mudança nas vidas
	return lives <= 0        # Retorna true se acabaram as vidas


func add_score(points: int):
	score += points          # Aumenta a pontuação
	emit_signal("score_changed", score)   # Emite sinal informando mudança na pontuação


func is_position_valid(pos: Vector2) -> bool:
	for used_pos in used_positions:       # Verifica cada posição já utilizada
		if pos.distance_to(used_pos) < MIN_DISTANCE:   # Se a nova posição estiver muito próxima de uma existente
			return false     # Retorna falso (posição inválida)
	return true             # Se passar por todas as verificações, retorna verdadeiro


func register_position(pos: Vector2):
	used_positions.append(pos)    # Adiciona a posição ao array de posições usadas


func clear_positions():
	used_positions.clear()    # Limpa o array de posições usadas


func reset_lives():
	lives = 3                # Restaura o número de vidas para 3
	emit_signal("life_changed", lives)    # Emite sinal informando mudança nas vidas
