extends Control

@onready var mainbanner = $TextureRect
#@onready var background = %mm_bg

func _ready() -> void:
	#mainbanner.visible = true
	pass

func _on_mm_quit_pressed() -> void:
	get_tree().quit()


func _on_mm_sandbox_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level.tscn")
