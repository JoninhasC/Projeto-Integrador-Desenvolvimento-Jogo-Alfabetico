extends Area2D


signal letter_collected(letter_info)         # Sinal emitido quando uma letra é coletada pelo jogador

var letter: String                          # Armazena qual letra este nó representa
var color: String                          # Armazena a cor da letra
var texture: Texture2D                     # Armazena a textura da letra
var is_correct: bool = false               # Indica se esta é uma letra correta da palavra atual
var fall_speed = 400                       # Velocidade de queda da letra
var is_falling = true                      # Controla se a letra está caindo ou parou


func _ready():
	var sprite = $Sprite2D                 # Referência ao nó Sprite2D da letra
	var collision = $CollisionShape2D       # Referência ao nó de colisão
	
	sprite.texture = load_texture()         # Carrega a textura apropriada para a letra
	sprite.scale = Vector2(0.25, 0.25)      # Redimensiona o sprite para 25% do tamanho original
	
	if collision:                           # Se existe um nó de colisão
		var shape = RectangleShape2D.new()  # Cria uma nova forma retangular
		shape.size = Vector2(64, 64)        # Define o tamanho da colisão (256 * 0.25)
		collision.shape = shape             # Aplica a forma ao nó de colisão


func _physics_process(delta):
	if is_falling:                         # Se a letra ainda está caindo
		position.y += fall_speed * delta    # Move a letra para baixo baseado na velocidade
		
		var bodies = get_overlapping_bodies()  # Obtém todos os corpos colidindo
		for body in bodies:                    # Para cada corpo
			if body is TileMap:                # Se for um TileMap
				is_falling = false             # Para de cair
				break


func setup(new_letter: String, new_color: String, correct: bool = false):
	letter = new_letter                    # Define qual letra é
	color = new_color                      # Define a cor da letra
	is_correct = correct                   # Define se é uma letra correta


func _on_area_entered(area):
	if area.get_parent().is_in_group("player"):    # Se colidiu com o player
		emit_signal("letter_collected", {"letter": letter, "is_correct": is_correct})    # Emite sinal de coleta
		queue_free()                                # Remove a letra da cena


func load_texture() -> Texture2D:
	var path = "res://sprites/LETTERS/%s/letter_%s.png" % [color, letter.to_upper()]    # Constrói o caminho da textura
	return load(path) if ResourceLoader.exists(path) else null    # Ca
