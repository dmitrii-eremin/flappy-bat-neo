extends CanvasLayer

signal on_resume()

@onready var _user_data = UserData.new()

func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	on_resume.emit()

func _on_main_menu_button_pressed() -> void:
	_user_data.update_score(GameData.gained_score)

	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
