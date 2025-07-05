extends State

class_name SpecialMoveState

@export var specialMoveName : String = "Special Move"
@export var ground_state : State


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if(anim_name == specialMoveName):
		next_state = ground_state
