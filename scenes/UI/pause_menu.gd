extends CanvasLayer

signal on_resume()


func _on_resume_button_pressed() -> void:
	on_resume.emit()

func _on_main_menu_button_pressed() -> void:
	get_tree().quit()
