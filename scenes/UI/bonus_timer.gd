extends Label

signal on_finished()

@onready var _time_left: int = 0
@onready var _timer: Timer = $Timer

func start(seconds: int) -> void:
	show()
	_time_left = seconds
	_update_text()
	_timer.start()

func _ready() -> void:
	hide()
	_update_text()

func _update_text() -> void:
	var minutes: int = int(floor(_time_left / 60.0))
	var seconds: int = _time_left % 60
	text = "%02d:%02d" % [minutes, seconds]
	
func _finish() -> void:
	hide()
	_time_left = 0
	_timer.stop()
	on_finished.emit()

func _on_timer_timeout() -> void:
	_time_left -= 1
	if _time_left <= -1:
		_finish()
	else:
		_update_text()
