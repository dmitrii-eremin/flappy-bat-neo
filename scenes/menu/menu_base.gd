extends Node2D

@onready var _background_music = $Sounds/BackgroundMusic

func _ready() -> void:
	_background_music.seek(GameData.bg_music_playback_position)
