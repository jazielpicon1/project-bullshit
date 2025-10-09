extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MainMenuMusic.stop_music()

func resume():
	get_tree().paused = false
