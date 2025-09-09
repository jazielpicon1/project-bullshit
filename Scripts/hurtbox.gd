class_name Hurtbox
extends Area2D

var attack_received : StringName
	
# Called when the node enters the scene tree for the first time.

func _ready():
	self.area_entered.connect(on_area_entered)
	
	

func on_area_entered(hitbox: Hitbox) -> void:
	if hitbox == null: 
		return
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
	print("ouch")
	$GettingHitNoise.play()
	$PunchingNoise.play()
	
	
	#Reminder to change collision mask when there is two players on the screen
	
