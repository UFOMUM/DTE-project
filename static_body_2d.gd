extends Area2D

@onready var game_manger: Node = %GameManger


func _on_body_entered(body):
	game_manger.add_point()
