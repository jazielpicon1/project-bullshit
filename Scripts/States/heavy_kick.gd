class_name HeavyKickState
extends State
@export var HeavyKick : State
@export var Ground : State

var has_attacked: bool



#func enterheavykickstate_():
	
		
		
		
	


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Karate Man animations/heavy kick":
		next_state = HeavyKick
		next_state = Ground
