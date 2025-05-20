#class_name PlayerState
#extends State
#
#@onready var player: Player1 = get_tree().get_first_node_in_group("Player1")
#
#var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity", -9.8)
#
##Animation Names
#var idle_anim: String = "Karate man animation_standing"
#var walk_anim: String = "Karate Man animations_walking"
#
##States 
#@export_group("States")
#@export var idle_state: PlayerState
#@export var walk_state: PlayerState
#
##Input Keys 
#var movement_key: String = "Walk"
#var left_key: String = "Left"
#var right_key: String = "Right"
#
##Base fn 
#
#func process_physics(delta: float) -> State:
	#player.velocity.y += gravity * delta
	#player.move_and_slide()
	#return null
