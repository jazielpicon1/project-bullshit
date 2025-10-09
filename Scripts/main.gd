extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	resume()
	print("Hello World!")
	$Label.text = "Deez Nuts"
	$Label.modulate = Color.GREEN

#  func _input(event):
	#if event.is_action_pressed("Walk Foward"):
		# $AnimatedSprite2D.play("Walking")
func resume():
	get_tree().paused = false
