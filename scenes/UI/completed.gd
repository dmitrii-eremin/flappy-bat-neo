extends Control

@onready var _bat_sprite = $AnimatedSprite2D
@onready var _score = $ScoreContainer/Score

func _ready() -> void:
	_score.text = "{0}".format([GameData.gained_score])

func _on_turn_bat_timer_timeout() -> void:
	_bat_sprite.flip_h = not _bat_sprite.flip_h

func _on_play_again_button_pressed() -> void:
	GameData.gained_score = 0
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_main_menu_button_pressed() -> void:
	get_tree().quit()
