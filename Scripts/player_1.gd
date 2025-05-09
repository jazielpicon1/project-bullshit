extends CharacterBody2D

func _input(event):
	if event.is_action_pressed("Walk Foward"):
		$AnimatedSprite2D.play("walking")
