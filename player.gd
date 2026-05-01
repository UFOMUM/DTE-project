extends CharacterBody2D

@export var speed: float = 100.0
@onready var game_manger: Node = %GameManger

func _on_area_2d_body_entered(body):
	game_manger.add_point()

func _physics_process(_delta: float) -> void:
	# 1. Get the input direction using the built-in Vector2 helper
	# This handles UI actions (up, down, left, right) automatically
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# 2. Apply movement
	if direction != Vector2.ZERO:
		# direction is already normalized by get_vector, 
		# so diagonal movement isn't faster than cardinal
		velocity = direction * speed
	else:
		# Smoothly stop the character
		velocity = velocity.move_toward(Vector2.ZERO, speed)

	# 3. Move and Slide handles collisions and delta time internally
	move_and_slide()
