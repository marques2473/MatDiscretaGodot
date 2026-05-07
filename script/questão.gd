extends CanvasLayer

const _RESPOSTA: PackedScene = preload("res://scene/Resposta.tscn")

@onready var label_pergunta: Label = $Label

var player: CharacterBody2D
var hud: CanvasLayer
var placa_origem
var pergunta: String
var resposta_correta: String

func _ready() -> void:
	label_pergunta.text = pergunta

func _on_responder_pressed() -> void:
	var tela_resposta = _RESPOSTA.instantiate()

	tela_resposta.player = player
	tela_resposta.placa_origem = placa_origem
	tela_resposta.resposta_correta = resposta_correta

	hud.add_child(tela_resposta)
	queue_free()

func _on_voltar_pressed() -> void:
	player.can_move = true
	InteractionManager.can_interact = true
	queue_free()
