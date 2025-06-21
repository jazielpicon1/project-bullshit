extends State

class_name AirState

@export var landing_state : State
@export var landing_animation : String = "landing"

func state_process(delta):
	if(character.is_on_floor()):
		next_state = landing_state
	
func state_input(event : InputEvent):
	#Handles attack animations in the air
	if(event.is_action_pressed("Attack Button")):
		get_input()
		
func on_exit():
	if(next_state == landing_state):
		playback.travel(landing_animation)


func get_input():
	if Input.is_action_just_pressed("Light Punch"):
		playback.travel("jump punch")
		character.attack_animation = true
		return
	if Input.is_action_just_pressed("Heavy Punch"):
		playback.travel("jump punch")
		character.attack_animation = true
		return
	if Input.is_action_just_pressed("Light Kick"):
		playback.travel("Karate Man animations_jump kick")
		character.attack_animation = true
		return
	if Input.is_action_just_pressed("Heavy Kick"):
		playback.travel("Karate Man animations_jump kick")
		character.attack_animation = true
		return
