extends CanvasLayer

@onready var divisor: ColorRect = $divisor
@onready var mensagem: Label = $mensagem
@onready var input_resposta: LineEdit = $input_resposta
@onready var confirmar: Button = $confirmar
@onready var voltar: Button = $voltar

var player: CharacterBody2D
var placa_origem
var resposta_correta: String

func _ready() -> void:
	input_resposta.text_submitted.connect(_verificar_resposta)
	divisor.mouse_filter = Control.MOUSE_FILTER_IGNORE

	mensagem.text = "Digite sua resposta:"
	input_resposta.grab_focus()

	confirmar.pressed.connect(_verificar_resposta)
	voltar.pressed.connect(_on_voltar_pressed)

func _verificar_resposta(texto: String = "") -> void:
	var resposta_digitada = input_resposta.text.strip_edges().to_lower()
	var certa = resposta_correta.strip_edges().to_lower()

	if resposta_digitada == certa:
		mensagem.text = "Resposta correta!"
		placa_origem.acertou = true

		await get_tree().create_timer(0.8).timeout

		_liberar_player()
		queue_free()
	else:
		mensagem.text = "Resposta errada! Tente novamente."
		input_resposta.text = ""
		input_resposta.grab_focus()

func _on_voltar_pressed() -> void:
	_liberar_player()
	queue_free()

func _liberar_player() -> void:
	player.can_move = true
	InteractionManager.can_interact = true
