extends State

class_name CrouchingState

@export var ground_state : State

func state_input(event : InputEvent):
	#Handles the jump animation.
	if(event.is_action_released("Crouch")):
		next_state = ground_state

func on_exit():
	if(next_state == ground_state):
		playback.travel("Walk")
