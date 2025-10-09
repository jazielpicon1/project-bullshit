extends State

class_name SkrrtState

@export var ground_state : State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if (anim_name == "Karate Man animations/skrrt"):
		next_state = ground_state
