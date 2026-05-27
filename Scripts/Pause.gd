extends Node

@onready var pause_lable: Label = $"Pause Lable"


func _ready():
	# This ensures the script keeps running even when the game is paused.
	# You can also set this in the Inspector under 'Process > Mode'.
	process_mode = Node.PROCESS_MODE_ALWAYS

func _unhandled_input(event):
	# Check if the 'P' key was just pressed
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_P:
			toggle_pause()

func toggle_pause():
	# Get the current pause state and flip it
	var current_state = get_tree().paused
	get_tree().paused = !current_state
	
	# Optional: Debug console feedback
	if get_tree().paused:
		print("Game Paused")
		pause_lable.visible = true
	else:
		print("Game Resumed")
		pause_lable.visible = false
