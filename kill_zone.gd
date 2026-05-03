extends Area2D

@onready var timer: Timer = $Timer


func _on_body_entered(body: Node2D) -> void:
	print("IDK")
	timer.start()


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Game Over.tscn")
