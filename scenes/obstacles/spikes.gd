extends Node2D

@onready var _sprite: Sprite2D = $Sprite2D

signal on_screen_exited()

func get_width() -> float:
	return _sprite.get_rect().size.x * 2

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	on_screen_exited.emit()

func _on_time_to_destroy_notifier_screen_exited() -> void:
	call_deferred("queue_free")
