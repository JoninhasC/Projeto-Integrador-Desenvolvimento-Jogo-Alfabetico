extends Node

var labels = []

var cores : Array = ["yellow", "red", "blue", "green", "orange", "purple", "pink", "brown", "black", "white"]
var alfabeto : String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
var caracteres_alfabeto : Array = alfabeto.split("")
var caracteres_do_alfabeto_sem_palavra : Array = alfabeto.split("")
var cores_path = ["azul", "cinza_claro", "cinza_escuro", "madeira", "marrom", "amarelo"]
var caracteres_da_palavra : Array 
var vida = 3
var palavra : String 
var cor_atual : int = 0
var volume : int 
var nivel : String 
var modalidade : String
var nivel_modalidade = [
	{
		"nivel": "facil",
		"categorias": {
			"animais": ["asa", "boi", "gato", "pato", "rato", "sapo"],
			"frutas": ["uva", "figo", "maçã", "pera"],
			"objetos": ["bola", "casa", "dado", "faca", "lua", "mesa", "sol"]
		}
	},
	{
		"nivel": "intermediario",
		"categorias": {
			"animais": ["cabras", "coelho", "girafa", "macaco", "ovelha", "tigres"],
			"frutas": ["banana", "limão", "mamão", "melão"],
			"objetos": ["cadeira", "escada", "janela", "lápis", "quadro"]
		}
	},
	{
		"nivel": "dificil",
		"categorias": {
			"animais": ["borboleta", "elefante", "papagaio", "tartaruga"],
			"frutas": ["abacaxi", "morango", "melancia"],
			"objetos": ["bicicleta", "geladeira", "telefone", "televisão"]
		}
	}
]
