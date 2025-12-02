extends CanvasLayer

@onready var _score = $Score
@onready var _bonus_timer = $MarginContainer/BonusTimer

signal on_jump_requested()
signal on_pause_requested()

func set_score(value: int) -> void:
	_score.set_score(value)
	
func set_bonus_timer(seconds: int) -> void:
	_bonus_timer.start(seconds)

func _on_pause_button_pressed() -> void:
	on_pause_requested.emit()

func _on_control_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") or (event is InputEventScreenTouch and event.pressed):
		on_jump_requested.emit()
