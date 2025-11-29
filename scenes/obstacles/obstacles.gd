extends Node2D

signal on_player_passed()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	call_deferred("queue_free")

func _on_obstacle_passed_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		on_player_passed.emit()
