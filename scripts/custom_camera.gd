extends Camera2D

var _moving_obstacles_count: int = 0
var _shake_amount: float = 0.0

var is_camera_shaking: bool:
	get: return _moving_obstacles_count > 0

const SHAKE_INTENSITY: float = 5.0
const SHAKE_DECAY_RATE: float = 4.0

func _ready() -> void:
	GameData.on_obstacle_started_to_move.connect(_obstacle_started)
	GameData.on_obstacle_stopped_to_move.connect(_obstacle_stopped)
	
func _physics_process(delta: float) -> void:
	if not is_camera_shaking and _shake_amount <= 0.0:
		offset = Vector2.ZERO
		return
	
	# Update shake decay
	if _shake_amount > 0.0:
		_shake_amount = move_toward(_shake_amount, 0.0, SHAKE_DECAY_RATE * delta)
	
	# Apply random shake offset
	var shake_offset = Vector2(
		randf_range(-_shake_amount, _shake_amount),
		randf_range(-_shake_amount, _shake_amount)
	)
	offset = shake_offset
	
func _obstacle_started() -> void:
	_moving_obstacles_count += 1
	_shake_amount = SHAKE_INTENSITY
	
func _obstacle_stopped() -> void:
	_moving_obstacles_count -= 1
