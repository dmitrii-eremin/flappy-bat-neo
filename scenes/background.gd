extends Node2D

@export var background_speed: float = 0.25
@export var foreground_speed: float = 0.50

func _ready() -> void:
	$BackgroundParallax.scroll_scale.x = background_speed
	$ForegroundParallax.scroll_scale.x = foreground_speed
