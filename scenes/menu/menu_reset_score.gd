extends Node2D

@onready var _score_label = $CanvasLayer/TitleMarginContainer/VBoxContainer/ScoreLabel

var _user_data: UserData = UserData.new()

func _ready() -> void:
	var score = _user_data.load_score()
	_update_score_text(score)
	
func _update_score_text(score: int) -> void:
	_score_label.text = "{0}".format([score])

func _on_yes_button_pressed() -> void:
	_user_data.reset_score()
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")

func _on_no_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
