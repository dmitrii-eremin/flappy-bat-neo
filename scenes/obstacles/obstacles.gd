extends Node2D

signal on_player_passed()

@onready var _upper_obstacle = $Up
@onready var _lower_obstacle = $Down
@onready var _move_sound = $Sounds/MoveObstaclesSound

@onready var _original_upper_pos: Vector2 = _upper_obstacle.position
@onready var _original_lower_pos: Vector2 = _lower_obstacle.position

@onready var _upper_target_pos: Vector2 = _original_upper_pos + Vector2(0, -_moving_delta)
@onready var _lower_target_pos: Vector2 = _original_lower_pos + Vector2(0, _moving_delta)

var _make_wider: bool = false
var _is_now_visible: bool = false

var _is_signaled_about_moving_started: bool = false
var _is_signaled_about_moving_stopped: bool = false

const _moving_speed: float = 2.0
const _moving_delta: int = 192

func _physics_process(delta: float) -> void:
	if not _make_wider or not _is_now_visible:
		return
		
	if not _is_signaled_about_moving_started:
		_is_signaled_about_moving_started = true
		GameData.on_obstacle_started_to_move.emit()

	_upper_obstacle.position = _upper_obstacle.position.lerp(_upper_target_pos, delta * _moving_speed)
	_lower_obstacle.position = _lower_obstacle.position.lerp(_lower_target_pos, delta * _moving_speed)
	
	if not _is_signaled_about_moving_stopped and _is_signaled_about_moving_started and abs(_upper_obstacle.position.y - _upper_target_pos.y) < 20:
		_is_signaled_about_moving_stopped = true
		GameData.on_obstacle_stopped_to_move.emit()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if _is_signaled_about_moving_started and not _is_signaled_about_moving_stopped:
		GameData.on_obstacle_stopped_to_move.emit()
	call_deferred("queue_free")

func _on_obstacle_passed_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		on_player_passed.emit()
		
func make_wider(value: bool) -> void:
	_make_wider = value

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	if _make_wider:
		_is_now_visible = true
		_move_sound.play()
