extends Label

@export var state_machine : StateMachine


#Textbox that shows what state the player is in
func _process(delta):
	text = "State: " + state_machine.current_state.name
