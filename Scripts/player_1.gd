class_name Player1
extends CharacterBody2D

#@onready var state_machine: StateMachine = $"StateMachine"
#@onready var animation : AnimationPlayer = $AnimationPlayer
#
#func _ready(): state_machine.init()
#
#func _process(delta): state_machine.process_frame(delta)
#
#func _physics_process(delta): state_machine.process_physics(delta)
#
#func _input(event): state_machine.process_input(event)


var state_machine
@export var maxSpeed : float = 200.0
@export var jumpVelocity : float = -500.0

# Gets the default velocity of gravity from the project settings (980 px/s^2)
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animation_locked : bool = false
var attack_animation : bool = false
var direction : Vector2 = Vector2.ZERO
var last_direction := Vector2(1,0)
var was_in_air : bool = false

#sets state machine with the animations from the animation tree
func _ready():
	state_machine = $AnimationTree.get("parameters/playback")

#Gets input from the user and plays the according animation
func get_input():
	var current = state_machine.get_current_node()
	
	update_animation()
	update_facing_direction()
	if Input.is_action_just_pressed("Light Punch") && is_on_floor():
		state_machine.travel("Karate Man animations_light_punch")
		attack_animation = true
		stop_motion()
		return
	if Input.is_action_just_pressed("Heavy Punch") && is_on_floor():
		state_machine.travel("Karate Man animations_heavy punch")
		attack_animation = true
		stop_motion()
		return
	if Input.is_action_just_pressed("Light Kick") && is_on_floor():
		state_machine.travel("Karate Man animations_light kick")
		attack_animation = true
		stop_motion()
		return
	if Input.is_action_just_pressed("Heavy Kick") && is_on_floor():
		state_machine.travel("Karate Man animations_heavy kick")
		attack_animation = true
		stop_motion()
		return
	
func _physics_process(delta):
	#Adds gravity to the characters
	animation_finished()
	if not is_on_floor():
		velocity.y += gravity * delta
		was_in_air = true
		
	if was_in_air == true:
		land()
		
	was_in_air = false
	
	#Handles the movement and direction of the character
	direction = Input.get_vector("Walk Backwards","Walk Forward", "Crouch","Jump")
	
	#Handles horizontal movement 
	if not attack_animation:
		if direction:
			velocity.x = direction.x * maxSpeed
		else:
			velocity.x = move_toward(velocity.x, 0, maxSpeed)
	
	#Handles the jump animation.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		was_in_air = true
		jump()
	
	#Resumes movement after attack animation is finished
	if Input.is_action_just_released("Attack Button"):
		resume_motion()

	get_input()
	move_and_slide()

func update_animation():
	if not animation_locked:
		if direction.x != 0 && state_machine.get_current_node() != "Karate Man animations_jump-fall": 
			state_machine.travel("Karate Man animations_walking")
		else:
			state_machine.travel("Karate Man animations_standing")
		
func update_facing_direction():
	if direction.x > 0:
		$AnimatedSprite2D.scale.x = -0.2
	elif direction.x < 0:
		$AnimatedSprite2D.scale.x = 0.2
		
func jump():
	velocity.y = jumpVelocity
	state_machine.travel("Karate Man animations_jump-start")
	animation_locked = true
	
func land():
	state_machine.travel("Karate Man animations_jump-fall-loop") 
	animation_locked = true
	
func stop_motion():
	if attack_animation:
		velocity.x = 0

func resume_motion():
	attack_animation = false
	if direction:
		velocity.x = direction.x * maxSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, maxSpeed)
	


func animation_finished():
	var tempCurrent = state_machine.get_current_node()
	if tempCurrent == "Karate Man animations_jump-fall-loop" && is_on_floor():
		animation_locked = false
		was_in_air = false
