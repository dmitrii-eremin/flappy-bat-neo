extends CanvasLayer

@export var wait_time: int = 3

signal on_time_is_out()

@onready var _timer_label = $Control/Label
@onready var _timer = $Timer

var _current_wait_time: int = 0

func _ready() -> void:
	_set_current_time(wait_time)
	
func start() -> void:
	get_tree().paused = true
	_set_current_time(wait_time)
	show()
	_timer.start()

func _on_timer_timeout() -> void:
	_set_current_time(_current_wait_time - 1)
	if _current_wait_time <= 0:
		_current_wait_time = 0
		_timer.stop()
		hide()
		get_tree().paused = false
		on_time_is_out.emit()

func _set_current_time(value: int) -> void:
	_current_wait_time = value
	_timer_label.text = "{0}".format([value])
