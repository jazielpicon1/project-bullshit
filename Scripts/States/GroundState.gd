extends State

class_name GroundState

#All the variables you will see and be able to change in the inspector tab
@export var jumpVelocity : float = -1500.0
@export var air_state : State
@export var crouching_state : State
@export var dead_state : State
@export var dash_state : State
@export var hit_state : State
@export var playerID = 1
@export var health: Health
@export var specialMove_state : State
@export var dash_speed : float = 1800.0

#A bunch of bullshit
var dashing : bool = false
var can_dash = true
var isBlocking : bool = false
var isCrouching : bool = false
var isHit : bool = false
var timer : Timer
enum {Punch, Kick, Right, Left, Down}
enum {light_attack, heavy_attack, special_move}
var Sequence : Array = []
var names : Array = MoveSetManager.karateManMoves.keys()

func on_enter():
	isCrouching = false
	isHit = false 


func state_input(event : InputEvent):
	#Handles the jump animation.
	if(event.is_action_pressed("Jump_%s" % [playerID])):
		jump()
	#Handles the attack animations on the ground.
	if(event.is_action_pressed("Attack Button_%s" % [playerID])):
		get_input()
	if(event.is_action_pressed("Crouch_%s" % [playerID])):
		crouch()
	if(event.is_action_pressed("Block_%s" % [playerID])):
		isBlocking = true
	if(event.is_action_released("Block_%s" % [playerID])):
		isBlocking = false
	if not event is InputEventKey:
		return
	if not event.is_pressed():
		return
	#Adds all the input from the player into a input buffer system
	if event.is_action_pressed("Down_%s" % [playerID]):
		add_input_to_sequence(Down)
	elif event.is_action_pressed("Right_%s" % [playerID]):
		add_input_to_sequence(Right)
	elif event.is_action_pressed("Punch_%s" % [playerID]):
		add_input_to_sequence(Punch)
	elif event.is_action_pressed("Left_%s" % [playerID]):
		add_input_to_sequence(Left)
	elif event.is_action_pressed("Left_%s" % [playerID]) and character.scale.x == -1:
		add_input_to_sequence(Right)
	timer.start()
	check_sequence()	

#I don't need to explain these
func jump():
	character.velocity.y = jumpVelocity
	next_state = air_state
	playback.travel("Karate Man animations_jump-start")

func crouch():
	character.velocity.x = 0
	isCrouching = true
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
		
		
#Clears the input buffer when player fails to input the correct sequence
func _on_timeout():
	Sequence = []

#Starts the timer for the input buffer
func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 0.5
	timer.one_shot = true
	timer.timeout.connect(_on_timeout)

#Self-explanatory
func add_input_to_sequence(button : int):
	Sequence.push_back(button)
	
#Checks the input buffer to see if the players input matches one of the sequences in their corresponding moveset
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
			if Name == "Karate Lunge" or Name == "Karate Lunge Reversed":
				playback.travel("Karate Man animations_karate lunge")
				next_state = specialMove_state
				$KarateLungeSfx.play()
			if Name == "Karate Taunt":
				playback.travel("Karate Man animations_taunt")
				next_state = specialMove_state
			if Name == "Karate Dash" and can_dash:
				playback.travel("Karate Man animations_forward_dash")
				dashing = true
				can_dash = false
				next_state = dash_state
				$dash_timer.start()
				$dash_again_timer.start()
			Sequence = [] #clear input sequence
			return


#Handles the processes that occur once a hitbox enter a hurtbox(i.e playing the hurt animation, receiving damage, etc)
func _on_hurtbox_area_entered(hitbox: Hitbox) -> void:
	if hitbox != null and isBlocking != true and isCrouching != true and isHit != true:
		isHit = true
		print("Damage Taken: ", hitbox.damage)
		health.health -= hitbox.damage
		health.set_health(health.health - hitbox.damage)
		playback.travel("Karate Man animations_hurt-light_standing")
		next_state = hit_state
	elif isBlocking == true:
		var newDamage = 0
		health.health -= newDamage
		health.set_health(health.health - newDamage)
		playback.travel("Karate Man animations_block_standing")
		print("Damage Taken: ", newDamage)
	if health.health == 0:
		print("Its over dude...")
		next_state = dead_state
		playback.travel("Karate Man animations_dead")
	print("Remaining Health: ", health.health)

#Finishes the dash animation once the timer finishes
func _on_dash_timer_timeout() -> void:
	dashing = false

#Cooldown until the player can dash again
func _on_dash_again_timer_timeout() -> void:
	can_dash = true
