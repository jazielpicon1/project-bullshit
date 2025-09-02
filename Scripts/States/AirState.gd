extends State

class_name AirState

#All the variables you will see and be able to change in the inspector tab
@export var landing_state : State
@export var landing_animation : String = "landing"
@export var playerID = 1

#Transtions the player to landing state once they touch the ground
func state_process(delta):
	if(character.is_on_floor()):
		playback.travel("Karate Man animations_jump-end")
		next_state = landing_state
	
func state_input(event : InputEvent):
	#Handles attack animations in the air
	if(event.is_action_pressed("Attack Button_%s" % [playerID])):
		get_input()

#Plays the landing animation when the player is transitioning into landing state
func on_exit():
	if(next_state == landing_state):
		playback.travel(landing_animation)

#Gets the input and transitions to appropriate animation for moves performed while in the air
func get_input():
	if Input.is_action_just_pressed("Light Punch_%s" % [playerID]):
		playback.travel("jump punch")
		character.attack_animation = true
		return
	if Input.is_action_just_pressed("Heavy Punch_%s" % [playerID]):
		playback.travel("jump punch")
		character.attack_animation = true
		return
	if Input.is_action_just_pressed("Light Kick_%s" % [playerID]):
		playback.travel("Karate Man animations_jump kick")
		character.attack_animation = true
		return
	if Input.is_action_just_pressed("Heavy Kick_%s" % [playerID]):
		playback.travel("Karate Man animations_jump kick")
		character.attack_animation = true
		return
