extends State

class_name CrouchingState

@export var ground_state : State

func state_input(event : InputEvent):
	#Handles the jump animation.
	if(event.is_action_released("Crouch")):
		next_state = ground_state
	if(event.is_action_pressed("Attack Button")):
		get_input()

func on_exit():
	if(next_state == ground_state):
		playback.travel("Walk")
		
func get_input():
	if Input.is_action_just_pressed("Light Punch"):
		playback.travel("Karate Man animations_crouch punch")
		character.attack_animation = true
		return
	if Input.is_action_just_pressed("Heavy Punch"):
		playback.travel("Karate Man animations_crouch punch")
		character.attack_animation = true
		return
	if Input.is_action_just_pressed("Light Kick"):
		playback.travel("Karate Man animations_crouch kick")
		character.attack_animation = true
		return
	if Input.is_action_just_pressed("Heavy Kick"):
		playback.travel("Karate Man animations_crouch kick")
		character.attack_animation = true
		return
