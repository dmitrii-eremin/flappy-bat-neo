extends Node2D

@export var spawn_point: Node2D
@export var obstacles_array: Node2D
@export var bonuses_array: Node2D
@export var bonus_every_nth_obstacle: int = 3

signal on_player_passed()
signal on_bonus_collected(type: BonusClass.Type)

const OBSTACLE_Y_DELTA = 100

var ObstacleScene: PackedScene = preload("res://scenes/obstacles/obstacles.tscn")
var BonusScene: PackedScene = preload("res://scenes/bonuses/bonus.tscn")

@onready var _obstacles_till_bonus_left: int = bonus_every_nth_obstacle

var bonus_is_allowed: bool = true

func _ready() -> void:
	_spawn_new_obstacle()

func _on_spawn_timer_timeout() -> void:
	if _obstacles_till_bonus_left <= 0 and bonus_is_allowed:
		_obstacles_till_bonus_left = bonus_every_nth_obstacle
		_spawn_new_bonus()
	else:
		#_spawn_new_bonus()
		_spawn_new_obstacle()

func _spawn_new_bonus() -> void:
	var bonus = BonusScene.instantiate()
	var bonus_type = BonusClass.get_random_type()
	bonus.call_deferred("set_bonus_type", bonus_type)

	bonus.global_position.x = spawn_point.global_position.x
	bonus.global_position.y = spawn_point.global_position.y
	bonus.collected.connect(func(type: BonusClass.Type): on_bonus_collected.emit(type))
	bonuses_array.add_child(bonus)

func _spawn_new_obstacle() -> void:
	var obstacle = ObstacleScene.instantiate()
	obstacle.global_position.x = spawn_point.global_position.x
	obstacle.global_position.y = randi_range(-OBSTACLE_Y_DELTA, OBSTACLE_Y_DELTA)
	obstacle.on_player_passed.connect(func(): on_player_passed.emit())
	obstacles_array.add_child(obstacle)
	GameData.on_obstacle_spawned.emit(obstacle)
	_obstacles_till_bonus_left -= 1
