extends CharacterBody2D

# Stats
@export var speed: float = 300.0
@export var shove_cooldown: float = 1.5
@export var adrenaline_radius: float = 50.0

# State
var score: float = 0.0
var can_shove: bool = true
var cars_in_range: int = 0

# Node References
@onready var adrenaline_zone = $AdrenalineZone
@onready var shove_zone = $ShoveZone

func _physics_process(delta: float) -> void:
	# 1. Movement Logic
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()

	# 2. Adrenaline Scoring
	# Points are awarded based on how many cars are inside the AdrenalineZone
	var overlapping_areas = adrenaline_zone.get_overlapping_areas()
	cars_in_range = overlapping_areas.size()
	
	if cars_in_range > 0:
		score += cars_in_range * 10.0 * delta
		modulate = Color(1.5, 1.5, 1.5) # Slight "glow" effect when scoring
	else:
		modulate = Color(1, 1, 1) # Reset to normal

	# 3. Shove Input
	if Input.is_action_just_pressed("shove") and can_shove:
		execute_shove()

func execute_shove() -> void:
	can_shove = false
	
	# Find all cars in the ShoveZone and trigger their shove function
	var targets = shove_zone.get_overlapping_areas()
	for area in targets:
		if area.has_method("apply_shove"):
			area.apply_shove(global_position)
	
	# Visual feedback for the shove (brief flash)
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.1)
	tween.chain().tween_property(self, "scale", Vector2(1, 1), 0.1)
	
	# Cooldown Timer
	await get_tree().create_timer(shove_cooldown).timeout
	can_shove = true
