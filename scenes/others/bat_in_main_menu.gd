extends AnimatedSprite2D

@export var speed: float = 150.0
@export var points_of_interest: Array[Node2D]

var _current_point: Node2D = null

func _physics_process(delta: float) -> void:
	_update_current_poi()
	_move_towards_target(delta)
	
func _update_current_poi() -> void:
	if _current_point == null:
		_current_point = points_of_interest.pick_random()
		
func _move_towards_target(delta: float) -> void:
	var direction: Vector2 = (_current_point.global_position - global_position).normalized()
	position += speed * direction * delta
	
	var diff = _current_point.global_position - global_position
	if diff.length_squared() < 3 ** 2:
		_current_point = null
