extends Node2D

@onready var _hud = $HUD
@onready var _pause_menu = $PauseMenu
@onready var _bat = $Bat
@onready var _preparation_timer = $PreparationTimer
@onready var _spawner = $ObstaclesSpawner

var _score: int = 0
var _current_bonus_type: BonusClass.Type = BonusClass.Type.EMPTY

var _score_multiplier: int:
	get():
		return 1 if _current_bonus_type != BonusClass.Type.DOUBLE_SCORE else 2

func _ready() -> void:
	_hud.set_score(0)
	_preparation_timer.start()

func _on_obstacles_spawner_on_player_passed() -> void:
	_score += _score_multiplier
	_hud.set_score(_score)

func _on_bat_on_dead() -> void:
	GameData.gained_score = _score
	get_tree().change_scene_to_file("res://scenes/UI/completed.tscn")

func _on_hud_on_pause_requested() -> void:
	get_tree().paused = true
	_pause_menu.show()

func _on_pause_menu_on_resume() -> void:
	_pause_menu.hide()
	_preparation_timer.start()

func _on_hud_on_jump_requested() -> void:
	_bat.jump()

func _on_preparation_timer_on_time_is_out() -> void:
	pass # Replace with function body.

func _on_hud_on_joystick_input(direction: Vector2) -> void:
	_bat.set_direction(direction)

func _on_obstacles_spawner_on_bonus_collected(type: BonusClass.Type) -> void:
	_spawner.bonus_is_allowed = false
	_current_bonus_type = type
	_hud.set_bonus_timer(BonusClass.get_duration(type))

func _on_hud_on_bonus_time_is_out() -> void:
	_spawner.bonus_is_allowed = true
	_current_bonus_type = BonusClass.Type.EMPTY
