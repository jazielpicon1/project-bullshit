#class_name HeavyKickState
extends State
@export var HeavyKick : State

var has_attacked: bool



func enterheavykickstate_():
	if Input.is_action_just_pressed("Heavy Kick"):
		next_state = HeavyKick
		
		
	
	
#this is the old script
