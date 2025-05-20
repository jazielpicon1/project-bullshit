#class_name PlayerIdleState
#extends PlayerState
#
#
#func enter() -> void:
	#player.animation.play(idle_anim)
#
#func process_input(event: InputEvent) -> State:
	#super(event)
	#if event.is_action_pressed(movement_key): return walk_state
	#return null
