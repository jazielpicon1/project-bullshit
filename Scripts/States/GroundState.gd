extends State

class_name GroundState

@export var HeavyKick : State
@export var jumpVelocity : float = -900.0
@export var air_state : State
@export var crouching_state : State
@export var playerID = 1
var timer : Timer
enum {Punch, Kick, Right, Left, Down}
var Sequence : Array = []
var names : Array = MoveSetManager.karateManMoves.keys()
@export var specialMove_state : State


func state_input(event : InputEvent):
	#Handles the jump animation.
	if(event.is_action_pressed("Jump_%s" % [playerID])):
		jump()
	#Handles the attack animations on the ground.
	if(event.is_action_pressed("Attack Button_%s" % [playerID])):
		get_input()
	if(event.is_action_pressed("Crouch_%s" % [playerID])):
		crouch()
	if not event is InputEventKey:
		return
	if not event.is_pressed():
		return
	if event.is_action_pressed("Down_%s" % [playerID]):
		add_input_to_sequence(Down)
	elif event.is_action_pressed("Right_%s" % [playerID]):
		add_input_to_sequence(Right)
	elif event.is_action_pressed("Punch_%s" % [playerID]):
		add_input_to_sequence(Punch)
	elif event.is_action_pressed("Left_%s" % [playerID]) and character.scale.x >= -0.2:
		add_input_to_sequence(Right)
	timer.start()
	check_sequence()	

func jump():
	character.velocity.y = jumpVelocity
	next_state = air_state
	playback.travel("Karate Man animations_jump-start")

func crouch():
	character.velocity.x = 0
	next_state = crouching_state
	playback.travel("crouch")
	
func stop_motion():
	if character.attack_animation:
		character.velocity.x = 0
		

#Gets input from the user and plays the according animation
func get_input():
	if Input.is_action_just_pressed("Light Punch_%s" % [playerID]):
		playback.travel("Karate Man animations_light_punch")
		$LightPunchSfx.play()
		character.attack_animation = true
		stop_motion()
		return
	if Input.is_action_just_pressed("Heavy Punch_%s" % [playerID]):
		playback.travel("Karate Man animations_heavy punch")
		$HeavyPunchSfx.play()
		character.attack_animation = true
		stop_motion()
		return
	if Input.is_action_just_pressed("Light Kick_%s" % [playerID]):
		playback.travel("Karate Man animations_light kick")
		character.attack_animation = true
		stop_motion()
		return
	if Input.is_action_just_pressed("Heavy Kick_%s" % [playerID]):
		playback.travel("Karate Man animations_heavy kick")
		$HeavyKickSfx.play()
		character.attack_animation = true
		#enterheavykickstate_()
		stop_motion()
		return
		
		

func _on_timeout():
	print("You suck")
	Sequence = []

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1
	timer.one_shot = true
	timer.timeout.connect(_on_timeout)

func add_input_to_sequence(button : int):
	Sequence.push_back(button)
	

func check_sequence()->void:
	for Name in names:
		var combo:Array = MoveSetManager.karateManMoves[Name] #Give sequence of current Combo
		var trim: = Sequence.duplicate() #next steps would alter original sequence
		trim.reverse() #Because need to leave last entries
		trim.resize(combo.size()) #Trim to last needed count of entries
		trim.reverse() #return to right order
		if trim == combo: #Combo match
			print("Special Move: ", Name)
			$LightPunchSfx.stop()
			$HeavyPunchSfx.stop()
			$KarateLungeSfx.play()
			$KarateLungeSuccessNoise.play()
			playback.travel("Karate Man animations_karate lunge")
			next_state = specialMove_state
			Sequence = [] #clear input sequence
			return




#func enterheavykickstate_():
	#if Input.is_action_just_pressed("Heavy Kick"):
		#next_state = HeavyKick
		
