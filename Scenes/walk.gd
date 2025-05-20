#class_name PlayerWalkState
#extends PlayerState
#
#const WALK_SPEED : float = 2
#
## Called when the node enters the scene tree for the first time.
#func enter() -> void:
	#print("Walk State")
	#player.animation.play(walk_anim)
#
#func process_physics(delta: float) -> State:
	#super(delta)
	#do_move(get_move_dir())
	#return null
	#
#func get_move_dir() -> float:
	#return Input.get_axis(left_key, right_key)
	#
#func do_move(move_dir: float) -> void:
	#player.velocity.x = move_dir * WALK_SPEED
