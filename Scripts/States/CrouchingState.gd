extends State

class_name CrouchingState

@export var ground_state : State
@export var dead_state : State
@export var playerID = 1
@export var health: Health

var isStanding: bool = true
var isBlocking : bool = false

func state_input(event : InputEvent):
	#Returns character to standing state when crouch button is released
	if(event.is_action_released("Crouch_%s" % [playerID])):
		next_state = ground_state
	#Handles the attack animations on the ground
	if(event.is_action_pressed("Attack Button_%s" % [playerID])):
		get_input()
	if(event.is_action_pressed("Block_%s" % [playerID])):
		isBlocking = true
	if(event.is_action_released("Block_%s" % [playerID])):
		isBlocking = false

func on_exit():
	if(next_state == ground_state):
		playback.travel("Walk")
		isStanding = true

func on_enter():
	isStanding = false

#Gets the input and transitions to appropriate animation for moves performed while crouching
func get_input():
	if Input.is_action_just_pressed("Light Punch_%s" % [playerID]):
		playback.travel("Karate Man animations_crouch punch")
		character.attack_animation = true
		return
	if Input.is_action_just_pressed("Heavy Punch_%s" % [playerID]):
		playback.travel("Karate Man animations_crouch punch")
		character.attack_animation = true
		return
	if Input.is_action_just_pressed("Light Kick_%s" % [playerID]):
		playback.travel("Karate Man animations_crouch kick")
		character.attack_animation = true
		return
	if Input.is_action_just_pressed("Heavy Kick_%s" % [playerID]):
		playback.travel("Karate Man animations_crouch kick")
		character.attack_animation = true
		return
		
		
		
#Handles the processes that occur once a hitbox enter a hurtbox(i.e playing the hurt animation, receiving damage, etc)
func _on_hurtbox_area_entered(hitbox: Hitbox) -> void:
	if hitbox != null and isBlocking != true and isStanding != true:
		print("Damage Taken: ", hitbox.damage)
		health.health -= hitbox.damage
		health.set_health(health.health - hitbox.damage)
		playback.travel("Karate Man animations_hurt-light_crouch")
	elif isBlocking == true:
		var newDamage = 0
		health.health -= newDamage
		health.set_health(health.health - newDamage)
		playback.travel("Karate Man animations_block_crouching")
		print("Damage Taken: ", newDamage)
	if health.health == 0:
		print("Its over dude...")
		next_state = dead_state
		playback.travel("Karate Man animations_dead")
	print("Remaining Health: ", health.health)
