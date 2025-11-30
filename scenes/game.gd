extends Node2D

@onready var _hud = $HUD
@onready var _pause_menu = $PauseMenu
@onready var _bat = $Bat
@onready var _preparation_timer = $PreparationTimer

var _score: int = 0

func _ready() -> void:
	_hud.set_score(0)
	_preparation_timer.start()

func _on_obstacles_spawner_on_player_passed() -> void:
	_score += 1
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
