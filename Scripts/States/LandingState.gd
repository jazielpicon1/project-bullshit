extends State

class_name LandingState

@export var landing_animation_name: String = "landing"
@export var ground_state : State



#Change the player's state to ground state once the animation finishes
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if(anim_name == landing_animation_name):
		next_state = ground_state
