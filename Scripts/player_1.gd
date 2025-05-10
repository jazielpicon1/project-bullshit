extends CharacterBody2D

var max_speed = 100
var last_direction := Vector2(1,0)

func _physics_process(delta):
	var direction = Input.get_vector("Walk Backwards","Walk Foward", "Jump", "Crouch")
	velocity = direction * max_speed
	move_and_slide()
	
	if direction.length() > 0:
		last_direction = direction
		play_movement_animation(direction)
	else:
		play_idle_animation(last_direction)
		
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
	#if event.is_action_pressed("Walk Foward"):
	#	$AnimatedSprite2D.play("kennywalk")
		
