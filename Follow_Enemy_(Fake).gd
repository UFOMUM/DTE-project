extends CharacterBody2D

@export var speed: float = 10
var target_player: Node2D = null

func _physics_process(_delta):
	# If we don't have the player yet, try to find them
	if not target_player:
		var players = get_tree().get_nodes_in_group("player")
		if players.size() > 0:
			target_player = players[0]
	
	# If we found them, move toward them
	if target_player:
		var direction = global_position.direction_to(target_player.global_position)
		velocity = direction * speed
		move_and_slide()
