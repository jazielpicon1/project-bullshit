extends CharacterBody2D

var state_machine
var max_speed = 100
var last_direction := Vector2(1,0)


func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
func get_input():
	var current = state_machine.get_current_node()
	velocity = Vector2.ZERO
	if Input.is_action_just_pressed("Light Punch"):
		state_machine.travel("Karate Man animations_light_punch")
		return
	if Input.is_action_just_pressed("Heavy Punch"):
		state_machine.travel("Karate Man animations_heavy punch")
		return
	if Input.is_action_pressed("Walk Foward"):
		velocity.x += 1
		$AnimatedSprite2D.scale.x = -0.2
	if Input.is_action_pressed("Walk Backwards"):
		velocity.x -= 1
		$AnimatedSprite2D.scale.x = 0.2
	if Input.is_action_pressed("Jump"):
		velocity.y += 1
	if Input.is_action_pressed("Crouch"):
		velocity.y -= 1
	velocity.normalized() * max_speed
	if velocity.length() == 0:
		state_machine.travel("Karate Man animations_standing")
	if velocity.length() > 0:
		state_machine.travel("Karate Man animations_walking")
	
func _physics_process(delta):
	get_input()
	var direction = Input.get_vector("Walk Backwards","Walk Foward", "Jump", "Crouch")
	velocity = direction * max_speed
	
	
	if direction.length() > 0:
		last_direction = direction
		play_movement_animation(direction)
	else:
		play_idle_animation(last_direction)
	move_and_slide()
	
	#if direction.length() > 0:
	#	last_direction = direction
	#	play_movement_animation(direction)
	#else:
	#	play_idle_animation(last_direction)
		
func play_movement_animation(direction):
	if direction.x > 0:
		$AnimatedSprite2D.play("kennywalk")
	elif direction.x < 0:
		$AnimatedSprite2D.play("kennywalk")
		
func play_idle_animation(direction):
	if direction.x > 0:
		$AnimatedSprite2D.play("standing")
	elif direction.x < 0:
		$AnimatedSprite2D.play("standing")

#func _input(event):
	#if event.is_action_pressed("Basic Attack punch"):
	#	$AnimatedSprite2D.play("punching")
	
	#if event.is_action_pressed("Walk Foward"):
	#	$AnimatedSprite2D.play("kennywalk")
