extends State

class_name CrouchingState

@export var ground_state : State
@export var playerID = 1

func state_input(event : InputEvent):
	#Returns character to standing state when crouch button is released
	if(event.is_action_released("Crouch_%s" % [playerID])):
		next_state = ground_state
	#Handles Attack Animation on the ground
	if(event.is_action_pressed("Attack Button_%s" % [playerID])):
		get_input()

func on_exit():
	if(next_state == ground_state):
		playback.travel("Walk")
		
func get_input():
	if Input.is_action_just_pressed("Light Punch_%s" % [playerID]):
		playback.travel("Karate Man animations_crouch punch")
		character.attack_animation = true
		return
	if Input.is_action_just_pressed("Heavy Punch_%s" % [playerID]):
		playback.travel("Karate Man animations_crouch punch")
		character.attack_animation = true
		return
	if Input.is_action_just_pressed("Light Kick_%s" % [playerID]):
		playback.travel("Karate Man animations_crouch kick")
		character.attack_animation = true
		return
	if Input.is_action_just_pressed("Heavy Kick_%s" % [playerID]):
		playback.travel("Karate Man animations_crouch kick")
		character.attack_animation = true
		return
