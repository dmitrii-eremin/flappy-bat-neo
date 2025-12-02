extends Node2D

@onready var _score_label: Label = $CanvasLayer/MarginContainer/VBoxContainer/Label
@onready var _background_music = $Sounds/BackgroundMusic
@onready var _mode_button = $CanvasLayer/MarginContainer/VBoxContainer/ModeButton

var _user_data: UserData = UserData.new()

func _ready() -> void:
	var score = _user_data.load_score()
	_update_score_text(score)
	_update_mode_button_text()
	
func _update_score_text(score: int) -> void:
	_score_label.text = "SCORE: {0}".format([score])

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_credits_button_pressed() -> void:
	GameData.bg_music_playback_position = _background_music.get_playback_position()
	get_tree().change_scene_to_file("res://scenes/menu/menu_credits.tscn")

func _on_label_gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.is_pressed():
		get_tree().change_scene_to_file("res://scenes/menu/menu_reset_score.tscn")

func _on_mode_button_pressed() -> void:
	GameData.control_simple_mode = not GameData.control_simple_mode
	_update_mode_button_text()
	
func _update_mode_button_text() -> void:
	const MODES: Dictionary[bool, String] = {
		false: "MODE: HARD",
		true: "MODE: SIMPLE"
	}
	_mode_button.text = MODES[GameData.control_simple_mode]
