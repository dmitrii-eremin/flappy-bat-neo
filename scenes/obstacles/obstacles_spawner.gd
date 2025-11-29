extends Node2D

@export var spawn_point: Node2D
@export var obstacles_array: Node2D

signal on_player_passed()

const OBSTACLE_Y_DELTA = 100

var ObstacleScene: PackedScene = preload("res://scenes/obstacles/obstacles.tscn")

func _ready() -> void:
	_spawn_new_obstacle()

func _on_spawn_timer_timeout() -> void:
	_spawn_new_obstacle()

func _spawn_new_obstacle() -> void:
	var obstacle = ObstacleScene.instantiate()
	obstacle.global_position.x = spawn_point.global_position.x
	obstacle.global_position.y = randi_range(-OBSTACLE_Y_DELTA, OBSTACLE_Y_DELTA)
	obstacle.on_player_passed.connect(func(): on_player_passed.emit())
	obstacles_array.add_child(obstacle)
