extends Control

@onready var _score_label: Label = $MarginContainer/Label

func set_score(value: int) -> void:
	_score_label.text = "{0}".format([value])
