extends State

class_name DashingState
@export var DashingAnimName = "Dashing Animation"
@export var ground_state : State
@export var skrrt_state : State
@export var playerID = 1
var isSprinting : bool = false
# Called when the node enters the scene tree for the first time.

func state_input(event : InputEvent):
	if event.is_action_pressed("Right_%s" % [playerID]):
		isSprinting = true
		playback.travel("Karate Man animations_sprint")
	if event.is_action_released("Right_%s" % [playerID]) and isSprinting == true:
		isSprinting = false
		playback.travel("Karate Man animations_skrrt")
		next_state = skrrt_state
	

#Change the player's state to ground state once the animation finishes
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if (anim_name == DashingAnimName):
		next_state = ground_state
