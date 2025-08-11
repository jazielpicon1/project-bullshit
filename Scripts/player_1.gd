class_name Player1
extends CharacterBody2D


@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine: StateMachine = $StateMachine
@export var maxSpeed : float = 200.0
@export var jumpVelocity : float = -900.0
@export var playerID = 1
@export var health: Health

# Gets the default velocity of gravity from the project settings (980 px/s^2)
var gravity = 2200
var animation_locked : bool = false
var attack_animation : bool = false
var direction : Vector2 = Vector2.ZERO
var last_direction := Vector2(1,0)
var was_in_air : bool = false
var is_jumping : bool = false

#sets state machine with the animations from the animation tree
func _ready():
	animation_tree.active = true

func _physics_process(delta):
	#Adds gravity to the characters
	update_animation()
	update_facing_direction()
	
	if not is_on_floor():
		velocity.y += gravity * delta
		is_jumping = true
	else:
		if is_jumping: #now on ground
			is_jumping = false
	
	
	
	#for movement on the floor. LATERAL MOVE!!
	if not attack_animation:
		if is_on_floor():
			direction = Input.get_vector("Walk Backwards_%s" % [playerID],"Walk Forward_%s" % [playerID], "Crouch_%s" % [playerID],"Jump_%s" % [playerID])
			if direction.x != 0 && state_machine.check_if_can_move():
				velocity.x = direction.x * maxSpeed
			else:
				velocity.x = move_toward(velocity.x, 0, maxSpeed)
		else:
			velocity.x - velocity.x
	
	#Resumes movement after attack animation is finished
	if Input.is_action_just_released("Attack Button_%s" % [playerID]):
		resume_motion()

	move_and_slide()
	
# Update animation based on direction
func update_animation():
	animation_tree.set("parameters/Walk/blend_position", direction.x)
	if not animation_locked:
		if direction.x != 0: 
			#animation_tree.travel("Karate Man animations_walking")
			$AnimatedSprite2D.play("kennywalk")
		else:
			$AnimatedSprite2D.play("standing")
			#animation_tree.travel("Karate Man animations_standing")

# Update facing direction
func update_facing_direction():
	if direction.x > 0:
		$AnimatedSprite2D.scale.x = -0.2
	elif direction.x < 0:
		$AnimatedSprite2D.scale.x = 0.2
		

# Resume motion after attack animation is finished
func resume_motion():
	attack_animation = false
	if direction:
		velocity.x = direction.x * maxSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, maxSpeed)
	
func take_damage(amount : int) -> void:
	print("Damage Taken: ", amount)
	health.health -= amount
	health.set_health(health.health - amount)
	if health.health == 0:
		print("Its over dude...")
	print("Remaining Health: ", health.health)
	

func _on_health_health_depleted() -> void:
	print("Its over dude...")
