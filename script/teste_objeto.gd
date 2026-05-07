extends Node2D
class_name Porta1

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player: CharacterBody2D = $"../CavaleiroProt"

const _DIALOG_SCREEN: PackedScene = preload("res://scene/dialog_screen.tscn")

@export var _hud: CanvasLayer = null

var _dialog_data: Dictionary = {
	0: {
		"faceset": "res://sprites/ConstrucaoMapa/Captura de tela 2026-04-26 172656.png",
		"dialog": "A porta aparenta estar fechada",
		"title": "Porta",
	},
	1: {
		"faceset": "res://sprites/ConstrucaoMapa/Captura de tela 2026-04-26 173003.png",
		"dialog": "Pode ser que tenha alguma coisa a ver com essas placas",
		"title": "Cavaleiro",
	},
}

var _dialog_errado: Dictionary = {
	0: {
		"faceset": "res://sprites/ConstrucaoMapa/Captura de tela 2026-04-26 173003.png",
		"dialog": "As respostas ainda não estão corretas.",
		"title": "Cavaleiro",
	},
	1: {
		"faceset": "res://sprites/ConstrucaoMapa/Captura de tela 2026-04-26 173003.png",
		"dialog": "Tente responder todas as placas corretamente.",
		"title": "Cavaleiro",
	},
}

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	InteractionManager.can_interact = false
	player.can_move = false
	
	if todas_placas_corretas():
		print(todas_placas_corretas())
		print("todas_placas_corretas() #end")
		if Global.fase == 1:
			get_tree().change_scene_to_file("res://scene/segunda_fase.tscn")
			Global.fase = 2
			return
		if Global.fase == 2:
			get_tree().change_scene_to_file("res://scene/terceira_fase.tscn")
			Global.fase = 3
			return
		if Global.fase == 3:
			get_tree().change_scene_to_file("res://scene/quarta_fase.tscn")
			Global.fase = 4
			return
		if Global.fase == 4:
			get_tree().change_scene_to_file("res://scene/fase_final.tscn")
			Global.fase = 5
			return
		
		return
	
	var new_dialog: DialogScreen = _DIALOG_SCREEN.instantiate()
	new_dialog.player = player
	
	if Global.perguntou1:
		new_dialog.data = _dialog_errado
	else:
		new_dialog.data = _dialog_data
		Global.perguntou1 = true
	
	_hud.add_child(new_dialog)

func todas_placas_corretas() -> bool:
	var placas = get_tree().get_nodes_in_group("placas")
	print("todas_placas_corretas() :metodo chamado")
	print("placas.size:")
	print(placas.size())
	
	print("Global.acertos:")
	print(Global.acertos)
	# comentar if para debug
	#if Global.acertos < 4:
		#print("return false")
		#return false
	
	if placas.size() < 4: #não sei se serve pra algo
		print("placas.size() < 4 #true")
		return false
	
	#for placa in placas:
		#if placa.player_acertou == false:
			#return false
	
	return true
