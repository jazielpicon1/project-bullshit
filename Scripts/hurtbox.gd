class_name Hurtbox
extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	collision_layer = 0
	collision_mask = 2
	self.area_entered.connect(on_area_entered)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_area_entered(hitbox:Hitbox) -> void:
	if hitbox == null: return
	
	print("ouch")
	
	
