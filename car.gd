extends Area2D

@export var speed = 250.0
var is_stunned = false

func _ready():
	# Connect the screen notifier to delete the car when it's gone
	$VisibleOnScreenNotifier2D.screen_exited.connect(queue_free)

func _physics_process(delta):
	if not is_stunned:
		# Move down the screen
		global_position.y += speed * delta

# The function your Player will call when shoving
func get_shoved(player_position: Vector2):
	is_stunned = true
	var push_direction = (global_position - player_position).normalized()
	
	var shove_tween = create_tween()
	# Shove back 60 pixels quickly
	shove_tween.tween_property(self, "global_position", global_position + (push_direction * 60), 0.2)
	shove_tween.finished.connect(func(): is_stunned = false)
