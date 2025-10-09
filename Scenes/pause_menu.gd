extends Control
@onready var pause_menu = $"."


#@onready var options_menu = $options_menu as OptionsMenu #REMOVABLE

# Called when the node enters the scene tree for the first time.


func _ready():
	
	$AnimationPlayer.play("RESET")
	
	

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	
	
	
	
func testEsc():
	
	if Input.is_action_just_pressed("Esc") and get_tree().paused == false:
		pause_menu.show()
		pause()
		
		
		
		
	elif Input.is_action_just_pressed("Esc") and get_tree().paused == true:
		pause_menu.hide()
		resume()
		
		
			
func pauseProcess():
	if get_tree().paused==false:
		pause_menu.hide()
	else:
		pause_menu.show()
	
 
#TIME STOP IS PRESENT. CANNOT ACT BECAUSE TIME STOP IS ACTIVE. THIS APPLIES TO THE OPTION MENU, TOO!!!!

func _on_button_pressed(): #need to rename
	resume()
	


func _on_button_2_pressed(): #need to rename AND VOID AS REMOVABLE IT IS REMOVABLE
	
	get_tree().change_scene_to_file("res://Scenes/options_menu.tscn")
	
	if Input.is_action_just_pressed("Esc") and get_tree().paused == false:
		resume()

	
	
	
	
	
	
	
	#this will be changed to a different options menu than the one from main menu??? or just leave it the same???


func _on_button_3_pressed(): #need to rename
	get_tree().quit()
	
	#very brutal but this will NOT be the final iteration of the pause button. this is just used as a quit button for this specific scene

func _process(_delta):
	testEsc()
	
