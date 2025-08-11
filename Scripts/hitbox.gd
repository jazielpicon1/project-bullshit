class_name Hitbox
extends Area2D

@export var damage := 10


#func _init() -> void:
	#collision_layer = 2
	#collision_mask = 0
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
