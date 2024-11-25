extends RichTextLabel

var largura = 300
var altura = 300
# Called when the node enters the scene tree for the first time.
func _ready():
	set_use_bbcode(true)
	self.set_size(Vector2(largura, altura))
	#self.scroll_active = true
	carregar_imagem_correspondente_a_palavra(Global.palavra)
	print(Global.palavra)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	carregar_imagem_correspondente_a_palavra(Global.palavra)
	
func carregar_imagem_correspondente_a_palavra(palavra):
	var caminho = "res://sprites/imagens_das_palavras/%s.jpg" % [palavra]
	#self.bbcode_text = "[img=64,64] %s [/img]" % caminho
	if FileAccess.file_exists(caminho):
		self.bbcode_text = "[img=]%s[/img]" %  caminho
	else:
		print("Arquivo não encontrado:", caminho)
