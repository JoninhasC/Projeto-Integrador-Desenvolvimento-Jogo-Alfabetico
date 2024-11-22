extends Node

var labels = []

var cores : Array = ["yellow", "red", "blue", "green", "orange", "purple", "pink", "brown", "black", "white"]
var alfabeto : String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
var caracteres_alfabeto : Array = alfabeto.split("")
var caracteres_do_alfabeto_sem_palavra : Array = alfabeto.split("")
var cores_path = ["azul", "cinza_claro", "cinza_escuro", "madeira", "marrom", "amarelo"]

var vida = 3

var cor_atual : int = 0
