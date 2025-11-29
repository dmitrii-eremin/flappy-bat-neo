extends CanvasLayer

@onready var _score = $Score

func set_score(value: int) -> void:
	_score.set_score(value)
