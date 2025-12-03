extends Node2D

signal on_player_passed()

@onready var _upper_obstacle = $Up
@onready var _lower_obstacle = $Down
@onready var _move_sound = $Sounds/MoveObstaclesSound

@onready var _original_upper_pos: Vector2 = _upper_obstacle.position
@onready var _original_lower_pos: Vector2 = _lower_obstacle.position

var _make_wider: bool = true
var _is_now_visible: bool = false

const _moving_speed: float = 2.0
const _moving_delta: int = 192

func _physics_process(delta: float) -> void:
	if not _make_wider or not _is_now_visible:
		return
	_upper_obstacle.position = _upper_obstacle.position.lerp(_original_upper_pos + Vector2(0, -_moving_delta), delta * _moving_speed)
	_lower_obstacle.position = _lower_obstacle.position.lerp(_original_lower_pos + Vector2(0, _moving_delta), delta * _moving_speed)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	call_deferred("queue_free")

func _on_obstacle_passed_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		on_player_passed.emit()
		
func make_wider(value: bool) -> void:
	_make_wider = value

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	_is_now_visible = true
	_move_sound.play()
