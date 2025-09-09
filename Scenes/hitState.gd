extends State

class_name HitState

@export var ground_state : State
@export var health: Health
@export var dead_state : State
var isStanding: bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func on_enter():
	$StunTimer.wait_time = 0.5
	$StunTimer.start()
	isStanding = false

func _on_stun_timer_timeout() -> void:
	next_state = ground_state
	isStanding = true


func _on_hurtbox_area_entered(hitbox: Hitbox) -> void:
	if hitbox != null and isStanding != true:
		print("Damage Taken: ", hitbox.damage)
		health.health -= hitbox.damage
		health.set_health(health.health - hitbox.damage)
		playback.travel("Karate Man animations_hurt-light_standing")
	if health.health == 0:
		print("Its over dude...")
		next_state = dead_state
		playback.travel("Karate Man animations_dead")
	print("Remaining Health: ", health.health)
