extends CharacterBody2D

@export var speed = 400.0
@export var base_points = 10

var cars_in_range = 0
var score = 0.0

@onready var shove_ray = $RayCast2D # Make sure this is enabled in Inspector

func _ready():
	# Connect Adrenaline Signals
	$AdrenalineArea.area_entered.connect(_on_adrenaline_entered)
	$AdrenalineArea.area_exited.connect(_on_adrenaline_exited)

func _physics_process(delta):
	# 1. Basic Movement (Left/Right/Up/Down)
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()

	# 2. Adrenaline Scoring
	if cars_in_range > 0:
		score += base_points * cars_in_range * delta
		# Optional: print(int(score)) to debug

	# 3. The Shove Input
	if Input.is_action_just_pressed("ui_accept"): # Spacebar or Enter
		shove_action()

func _on_adrenaline_entered(_area):
	cars_in_range += 1

func _on_adrenaline_exited(_area):
	cars_in_range = max(0, cars_in_range - 1)

func shove_action():
	if shove_ray.is_colliding():
		var target = shove_ray.get_collider()
		# Check if the target is a Car and has the 'get_shoved' function
		if target.has_method("get_shoved"):
			target.get_shoved(global_position)
