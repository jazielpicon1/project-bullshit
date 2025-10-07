class_name Player1
extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine: StateMachine = $StateMachine
@onready var healthbar = $Heathbar
#All the variables you will see and be able to change in the inspector tab
@export var maxSpeed : float = 300.0
@export var jumpVelocity : float = -900.0
@export var dash_speed : float = 500.0
@export var playerID = 1
@export var current_state : State
@export var dash_state : State
@export var health : Health
#@export var health: Health

#Regular Degular variables
var gravity = 3000
var animation_locked : bool = false
var attack_animation : bool = false
var direction : Vector2 = Vector2.ZERO
var last_direction := Vector2(1,0)
var was_in_air : bool = false
var is_jumping : bool = false
var is_dashing : bool = false

#sets state machine with the animations from the animation tree
func _ready():
	animation_tree.active = true
	healthbar.init_health(health.health)

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
		#Checks to see if player is Dashing
		if state_machine.current_state == dash_state:
			is_dashing = true
		else:
			if is_dashing:
				is_dashing = false
		#Changes the player's speed while they are dashing
		if is_dashing:
			velocity.x = direction.x * dash_speed
	#Resumes movement after attack animation is finished
	if Input.is_action_just_released("Attack Button_%s" % [playerID]):
		resume_motion()
	move_and_slide()
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		var collider = c.get_collider()
		if c.get_collider() is CharacterBody2D:
			push_other_character(collider, c.get_normal())
	for i in get_slide_collision_count():
		if $RayCast2D.is_colliding():
			var c2 = get_slide_collision(i)
			var location = $RayCast2D.get_collision_point()
			var normal = $RayCast2D.get_collision_normal() 
			var object = c2.get_collider() 
			if object is CharacterBody2D:
				push_other_character(object, c2.get_normal())
		#var push_direction = -normal
		#var push_force = 100 
		#velocity += push_direction * push_force
			print("GET OFF ME!")
		
			print(object, location, normal)
 # In the pushing CharacterBody2D's script
func push_other_character(other_character: CharacterBody2D, collision_normal: Vector2):
	# Determine the direction of the push
	var push_direction = -collision_normal
	var push_force = 10000000 # Adjust this value for desired pushing strength
	# Apply the force to the other CharacterBody2D's velocity
	other_character.velocity += push_direction * push_force

# Update animation based on direction
func update_animation():
	animation_tree.set("parameters/Walk/blend_position", direction.x)
	if not animation_locked:
		if direction.x != 0: 
			$AnimatedSprite2D.play("kennywalk")
		else:
			$AnimatedSprite2D.play("standing")

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
		
	



func _on_hurtbox_area_entered(hitbox: Hitbox) -> void:
	healthbar.health = health.health
	
	


func _on_hurtbox_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Player1"):
		body.collision_layer = 1
		body.collision_mask = 1 
		


func _on_hurtbox_body_exited(body: CharacterBody2D) -> void:
	if body.is_in_group("Player1"):
		body.collision_layer = 2
		body.collision_mask = 2
