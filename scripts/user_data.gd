class_name UserData

const FILENAME: String = "user://userdata.ini"

func save_score(score: int) -> void:
	var config = ConfigFile.new()
	config.set_value("userdata", "score", score)
	config.save(FILENAME)

func load_score() -> int:
	var config = ConfigFile.new()
	var err = config.load(FILENAME)
	if err != OK:
		return 0
	return config.get_value("userdata", "score", 0)

func update_score(score: int) -> bool:
	var current_score: int = load_score()
	if score > current_score:
		save_score(score)
		return true
	return false
	
func reset_score() -> void:
	save_score(0)
