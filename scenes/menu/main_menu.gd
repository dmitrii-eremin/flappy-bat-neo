extends Node2D

@onready var _score_label: Label = $CanvasLayer/MarginContainer/VBoxContainer/Label

var _user_data: UserData = UserData.new()

func _ready() -> void:
	var score = _user_data.load_score()
	_update_score_text(score)
	
func _update_score_text(score: int) -> void:
	_score_label.text = "SCORE: {0}".format([score])

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/menu_credits.tscn")

func _on_label_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		get_tree().change_scene_to_file("res://scenes/menu/menu_reset_score.tscn")
