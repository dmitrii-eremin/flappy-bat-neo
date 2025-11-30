extends Node2D

@export var initial_spikes: Node2D
@export var spikes_parent: Node2D

var _current_spikes: Node2D = null

var _spikes_width: float = 0
var _spikes_pos: Vector2 = Vector2.ZERO

var SpikesScene = preload("res://scenes/obstacles/spikes.tscn")

func _ready() -> void:
	initial_spikes.on_screen_exited.connect(_on_exited_screen)
	_current_spikes = initial_spikes
	call_deferred("_on_update_spikes_width")
	
func _on_update_spikes_width() -> void:
	_spikes_width = _current_spikes.get_width()
	_spikes_pos = _current_spikes.global_position
	
func _on_exited_screen() -> void:
	_current_spikes = SpikesScene.instantiate()
	_current_spikes.global_position = _spikes_pos + Vector2(_spikes_width, 0)
	_current_spikes.on_screen_exited.connect(_on_exited_screen)
	_spikes_pos = _current_spikes.global_position
	spikes_parent.add_child(_current_spikes)
