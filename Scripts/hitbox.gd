class_name Hitbox
extends Area2D

var attack_type : StringName
enum {light_attack, heavy_attack, special_move}
#Test damage(subject to change for difference attack and moves)
@export var damage := 10


#func _init() -> void:
	#collision_layer = 2
	#collision_mask = 0
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


	
