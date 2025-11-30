extends Node2D

@onready var _hud = $HUD

var _score: int = 0

func _ready() -> void:
	_hud.set_score(0)

func _process(_delta: float) -> void:
	pass

func _on_obstacles_spawner_on_player_passed() -> void:
	_score += 1
	_hud.set_score(_score)

func _on_bat_on_dead() -> void:
	GameData.gained_score = _score
	get_tree().change_scene_to_file("res://scenes/UI/completed.tscn")
