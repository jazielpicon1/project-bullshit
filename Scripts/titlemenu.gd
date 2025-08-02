extends Control

@onready var mainbanner = $TextureRect
@onready var options_menu = $options_menu as OptionsMenu
#@onready var background = %mm_bg

func _ready() -> void:
	#mainbanner.visible = true
	$CenterContainer/VBoxContainer/MarginContainer/VBoxContainer/mm_campaign.grab_focus()

func _on_mm_quit_pressed() -> void:
	get_tree().quit()


func _on_mm_sandbox_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/TestRoom.tscn")
	
func _on_mm_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/options_menu.tscn")
	
