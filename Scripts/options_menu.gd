class_name OptionsMenu
extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer/VBoxContainer/op_exit.grab_focus()


func _on_op_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/titlemenu.tscn")
	
