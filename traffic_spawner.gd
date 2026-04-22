extends Node2D

@export var car_scene: PackedScene # Drag your Car.tscn here in the Inspector
@export var spawn_interval: float = 1.5
@export var base_car_speed: float = 250.0

@onready var spawn_timer = $SpawnTimer

func _ready():
	spawn_timer.wait_time = spawn_interval

func _on_spawn_timer_timeout():
	# 1. Create a new car instance
	var new_car = car_scene.instantiate()
	
	# 2. Decide Spawn Side (Left or Right)
	var spawn_on_left = [true, false].pick_random()
	var spawn_x = 0 if spawn_on_left else 1 # Assuming 1200px wide screen
	
	# 3. Choose a random Lane (Y-coordinate)
	# Adjust these numbers to match your road markings
	var spawn_y = randf_range(0,1) 
	
	# 4. Configure the car
	new_car.position = Vector2(spawn_x, spawn_y)
	new_car.direction = Vector2.RIGHT if spawn_on_left else Vector2.LEFT
	new_car.speed = base_car_speed
	
	# 5. Add to the scene
	add_child(new_car)

func _on_difficulty_timer_timeout():
	# Increase speed by 10% and make cars spawn slightly faster
	base_car_speed *= 1.1
	spawn_interval = max(0.4, spawn_interval - 0.1) # Don't go below 0.4s
	spawn_timer.wait_time = spawn_interval
	print("Level Up! Speed: ", base_car_speed)
