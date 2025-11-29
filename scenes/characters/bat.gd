extends CharacterBody2D

@export var speed: float = 150.0
@export var jump_speed: float = -500

func _physics_process(delta: float) -> void:
	velocity.x = speed
	velocity.y += Globals.GRAVITY * delta
	
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = jump_speed

	move_and_slide()
