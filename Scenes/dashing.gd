extends State

class_name DashingState
@export var DashingAnimName = "Dashing Animation"
@export var ground_state : State
# Called when the node enters the scene tree for the first time.

#Change the player's state to ground state once the animation finishes
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if (anim_name == DashingAnimName):
		next_state = ground_state
