extends Node
var main_menu_music = load("res://Sounds/Plok! SNES Music - Beach.mp3")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func stop_music():
	$AudioStreamPlayer.stream = main_menu_music
	$AudioStreamPlayer.stop()
