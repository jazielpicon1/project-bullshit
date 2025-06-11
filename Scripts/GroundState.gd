extends State

class_name GroundState

@export var jumpVelocity : float = -500.0
@export var air_state : State

func state_input(event : InputEvent):
	#Handles the jump animation.
	if(event.is_action_pressed("Jump")):
		jump()
	#Handles the attack animations on the ground.
	if(event.is_action_pressed("Attack Button")):
		get_input()
			

func jump():
	character.velocity.y = jumpVelocity
	next_state = air_state
	playback.travel("Karate Man animations_jump-start")
	
	
func stop_motion():
	if character.attack_animation:
		character.velocity.x = 0
		

#Gets input from the user and plays the according animation
func get_input():
	if Input.is_action_just_pressed("Light Punch"):
		playback.travel("Karate Man animations_light_punch")
		character.attack_animation = true
		stop_motion()
		return
	if Input.is_action_just_pressed("Heavy Punch"):
		playback.travel("Karate Man animations_heavy punch")
		character.attack_animation = true
		stop_motion()
		return
	if Input.is_action_just_pressed("Light Kick"):
		playback.travel("Karate Man animations_light kick")
		character.attack_animation = true
		stop_motion()
		return
	if Input.is_action_just_pressed("Heavy Kick"):
		playback.travel("Karate Man animations_heavy kick")
		character.attack_animation = true
		stop_motion()
		return
