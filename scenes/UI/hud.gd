extends CanvasLayer

@onready var _score = $Score

signal on_jump_requested()
signal on_pause_requested()

func set_score(value: int) -> void:
	_score.set_score(value)

func _on_pause_button_pressed() -> void:
	on_pause_requested.emit()

func _on_control_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		on_jump_requested.emit()
