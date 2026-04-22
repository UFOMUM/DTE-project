extends Area2D

# Movement Variables
var speed: float = 200.0
var direction: Vector2 = Vector2.RIGHT
var is_stunned: bool = false

func _process(delta: float) -> void:
	if not is_stunned:
		position += direction * speed * delta

# This is called by the Player script
func apply_shove(player_pos: Vector2) -> void:
	is_stunned = true
	
	# Calculate pushback direction (away from player)
	var push_dir = (global_position - player_pos).normalized()
	
	# Create a "Juicy" knockback effect
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	
	# Knock the car back 70 pixels and turn it yellow
	tween.parallel().tween_property(self, "position", position + (push_dir * 70), 0.2)
	tween.parallel().tween_property(self, "modulate", Color.YELLOW, 0.1)
	
	# Wait for stun duration
	await get_tree().create_timer(1.0).timeout
	
	# Return to normal
	is_stunned = false
	modulate = Color.WHITE

# Connect this signal in the Godot Editor (area_entered or body_entered)
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("Game Over! Final Score: ", body.score)
		get_tree().reload_current_scene()

# Clean up memory when the car leaves the screen
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
