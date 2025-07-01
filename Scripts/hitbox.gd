class_name Hitbox
extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	collision_layer = 2
	collision_mask = 0
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
