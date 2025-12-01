extends CharacterBody2D

@export var speed: float = 150.0
@export var jump_speed: float = -500

signal on_dead()

@onready var _sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var _dead_timer: Timer = $DeadTimer

@onready var _sound_fly = $Sounds/Fly
@onready var _sound_death = $Sounds/Death

enum State {
	FLY,
	DEAD
}

var _state: State = State.FLY
var _is_jump_requested: bool = false

func jump() -> void:
	_is_jump_requested = true

func _physics_process(delta: float) -> void:
	_select_velocity(delta)
	_move_bat()

func _select_velocity(delta: float) -> void:
	if _state == State.FLY:
		velocity.x = speed
		velocity.y += GameData.GRAVITY * delta
	else:
		velocity = Vector2.ZERO
		
	if global_position.y < 10 and velocity.y < 0:
		velocity.y = 0
	
	if _is_jump_requested:
		_sound_fly.play()
		velocity.y = jump_speed
		_is_jump_requested = false
		
func _move_bat() -> void:
	if _state == State.FLY:
		move_and_slide()
		_process_collisions()
	
func _process_collisions() -> void:
	for i in range(get_slide_collision_count()):
		var col = get_slide_collision(i)
		if col.get_collider().is_in_group("obstacle"):
			_on_hit_obstacle()
			break

func _on_hit_obstacle() -> void:
	_sound_death.play()
	_change_state(State.DEAD)
	
func _change_state(new_state: State) -> void:
	_state = new_state
	if _state == State.DEAD:
		_sprite.play("die")

func _on_animated_sprite_2d_animation_finished() -> void:
	if _state == State.DEAD:
		_sprite.visible = false
		_dead_timer.start()

func _on_dead_timer_timeout() -> void:
	on_dead.emit()
