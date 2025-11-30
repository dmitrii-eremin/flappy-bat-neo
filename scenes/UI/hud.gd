extends CanvasLayer

@onready var _score = $Score

signal on_pause_requested()

func set_score(value: int) -> void:
	_score.set_score(value)

func _on_pause_button_pressed() -> void:
	on_pause_requested.emit()
