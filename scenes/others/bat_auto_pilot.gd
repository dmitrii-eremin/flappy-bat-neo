extends Node2D

@export var is_enabled: bool = true

@onready var _jump_timer = $JumpTimer

var _can_jump: bool = true

func _process(_delta: float) -> void:
	if not is_enabled:
		return
	var bat = _get_bat()
	var obstacle = _get_next_obstacle(bat)
	if bat == null:
		return
	if obstacle == null:
		if bat.global_position.y > get_viewport_rect().size.y / 2:
			_jump(bat)
		return
	if bat.global_position.y > obstacle.global_position.y + 290:
		_jump(bat)
		
func _jump(bat: Node2D) -> void:
	if not _can_jump:
		return
	bat.jump()
	_can_jump = false
	_jump_timer.start()
	
func _get_bat() -> Node2D:
	var bats = get_tree().get_nodes_in_group("player")
	if bats.is_empty():
		return null
	return bats[0]
	
func _get_next_obstacle(bat: Node2D) -> Node2D:
	if bat == null:
		return null
	var obstacles = get_tree().get_nodes_in_group("obstacle")
	obstacles = obstacles.filter(func(o: Node2D): return o.global_position.x > bat.global_position.x - 16)
	if obstacles.is_empty():
		return null
	if obstacles.size() == 1:
		return obstacles[0]
	var closest_obstacle: Node2D = null
	for o: Node2D in obstacles:
		if closest_obstacle == null:
			closest_obstacle = o
		else:
			if o.global_position.x > bat.global_position.x and o.global_position.x < closest_obstacle.global_position.x:
				closest_obstacle = o	
	return closest_obstacle

func _on_jump_timer_timeout() -> void:
	_can_jump = true
