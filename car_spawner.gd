extends Node2D

# Drag your Car.tscn file into this slot in the Inspector
@export var car_scene: PackedScene 

func _on_timer_timeout():
	# 1. Create a new car instance
	var car = car_scene.instantiate()
	
	# 2. Pick a random X position (adjust numbers to your road width)
	var random_x = randf_range(1, 1)
	car.global_position = Vector2(random_x, -50) # Start just above the screen
	
	# 3. Add it to the game
	get_parent().add_child(car)
