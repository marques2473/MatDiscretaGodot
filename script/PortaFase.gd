extends Node2D
class_name PortaFaseScript

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player: CharacterBody2D = $"../CavaleiroProt"
@onready var hud: CanvasLayer = $HUD

const DIALOG_SCREEN: PackedScene = preload("res://scene/dialog_screen.tscn")

@export var proxima_fase: String = "res://scene/segunda_fase.tscn"

var dialogo_porta_fechada: Dictionary = {
	0: {
		"faceset": "res://sprites/ConstrucaoMapa/Captura de tela 2026-04-26 173003.png",
		"dialog": "A porta está trancada. Responda corretamente todas as placas desta sala.",
		"title": "Porta"
	}
}

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact() -> void:
	InteractionManager.can_interact = false
	player.can_move = false

	if _todas_placas_completas():
		InteractionManager.clear_areas()
		player.can_move = true
		get_tree().change_scene_to_file(proxima_fase)
	else:
		var dialogo = DIALOG_SCREEN.instantiate()

		dialogo.player = player
		dialogo.data = dialogo_porta_fechada

		hud.add_child(dialogo)

func _todas_placas_completas() -> bool:
	var no_placas = get_parent().get_node("placas")

	for placa in no_placas.get_children():
		if placa is Placa_quest:
			if not placa.acertou:
				return false

	return true
