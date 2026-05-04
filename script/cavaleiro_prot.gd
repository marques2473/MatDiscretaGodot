extends CharacterBody2D

@export var speed = 300
@onready var anim = $AnimatedSprite2D
var can_move = true

func _ready() -> void:
	InteractionManager.can_interact = true
	can_move = true

func get_input():
	if !can_move:
		velocity = Vector2.ZERO
		return

	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * speed
	
	if input_direction.x < 0:
		anim.flip_h = true   
	elif input_direction.x > 0:
		anim.flip_h = false  

func _physics_process(delta):
	get_input()
	move_and_slide()
	
	if velocity.length() > 0:
		if anim.animation != "run":
			anim.play("run")
	else:
		if anim.animation != "idle":
			anim.play("idle")
