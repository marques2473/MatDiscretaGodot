extends CanvasLayer

const _QUESTAO: PackedScene = preload("res://scene/questao.tscn")

var player: CharacterBody2D
var hud: CanvasLayer
var placa_origem
var pergunta: String
var resposta_correta: String

func _on_observar_pressed() -> void:
	var tela_questao = _QUESTAO.instantiate()

	tela_questao.player = player
	tela_questao.hud = hud
	tela_questao.placa_origem = placa_origem
	tela_questao.pergunta = pergunta
	tela_questao.resposta_correta = resposta_correta

	hud.add_child(tela_questao)
	queue_free()

func _on_sair_pressed() -> void:
	player.can_move = true
	InteractionManager.can_interact = true
	queue_free()
