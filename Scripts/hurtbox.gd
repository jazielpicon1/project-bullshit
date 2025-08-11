class_name Hurtbox
extends Area2D

#func _init() -> void:
	#collision_layer = 0
	#collision_mask = 2
	
# Called when the node enters the scene tree for the first time.

func _ready():
	self.area_entered.connect(on_area_entered)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_area_entered(hitbox: Hitbox) -> void:
	if hitbox == null: 
		return
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
	print("ouch")
	$GettingHitNoise.play()
	
	
	#Reminder to change collision mask when there is two players on the screen
	
