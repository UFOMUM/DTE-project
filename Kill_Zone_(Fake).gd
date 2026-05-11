extends Area2D

@onready var death_timer: Timer = $"Death Timer"


func _on_body_entered(body: Node2D) -> void:
	print("IDK")
	death_timer.start()


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Game_(Fake).tscn")
