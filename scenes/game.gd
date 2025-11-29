extends Node2D

var _score: int = 0

func _process(_delta: float) -> void:
	#print($Bat.global_position.y)
	pass

func _on_obstacles_spawner_on_player_passed() -> void:
	_score += 1
