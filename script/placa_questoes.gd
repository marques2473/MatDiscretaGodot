extends Node2D
class_name Placa_quest

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player: CharacterBody2D = $"../../CavaleiroProt"

const _MENU_INTERACAO: PackedScene = preload("res://scene/interact_options.tscn")

@export var _hud: CanvasLayer = null
@export var pergunta: String = "1 + 1 = ?"
@export var resposta_correta: String = "2"

var acertou: bool = false

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact() -> void:
	if acertou:
		print("★★★★★ acertou")
		Global.acertos += 1
		return

	InteractionManager.can_interact = false
	player.can_move = false

	var menu = _MENU_INTERACAO.instantiate()
	menu.player = player
	menu.hud = _hud
	menu.placa_origem = self
	menu.pergunta = pergunta
	menu.resposta_correta = resposta_correta

	_hud.add_child(menu)
