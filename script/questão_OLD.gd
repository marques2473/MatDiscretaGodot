extends CanvasLayer

const RESPOSTA_SCREEN = preload("res://scene/Resposta.tscn")

var pergunta: String
var placa: Placa_quest

@onready var label: Label = $Label

func _ready() -> void:
	label.text = pergunta

func _on_responder_pressed() -> void:
	var new_resposta = RESPOSTA_SCREEN.instantiate()
	new_resposta.placa = placa
	
	get_parent().add_child(new_resposta)
	queue_free()
