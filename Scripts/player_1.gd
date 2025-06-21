class_name Player1
extends CharacterBody2D


@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine: StateMachine = $StateMachine
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
	animation_tree.active = true
	print(MoveSetManager.nameDictionary[name][1])

	
func _physics_process(delta):
	#Adds gravity to the characters
	update_animation()
	update_facing_direction()
	if not is_on_floor():
		velocity.y += gravity * delta
	
	#Handles the movement and direction of the character
	direction = Input.get_vector("Walk Backwards","Walk Forward", "Crouch","Jump")
	
	#Handles horizontal movement 
	if not attack_animation:
		if direction.x != 0 && state_machine.check_if_can_move():
			velocity.x = direction.x * maxSpeed
		else:
			velocity.x = move_toward(velocity.x, 0, maxSpeed)
	
	#Resumes movement after attack animation is finished
	if Input.is_action_just_released("Attack Button"):
		resume_motion()

	move_and_slide()

func update_animation():
	animation_tree.set("parameters/Walk/blend_position", direction.x)
	if not animation_locked:
		if direction.x != 0: 
			#animation_tree.travel("Karate Man animations_walking")
			$AnimatedSprite2D.play("kennywalk")
		else:
			$AnimatedSprite2D.play("standing")
			#animation_tree.travel("Karate Man animations_standing")
		
func update_facing_direction():
	if direction.x > 0:
		$AnimatedSprite2D.scale.x = -0.2
	elif direction.x < 0:
		$AnimatedSprite2D.scale.x = 0.2
		


func resume_motion():
	attack_animation = false
	if direction:
		velocity.x = direction.x * maxSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, maxSpeed)
	
