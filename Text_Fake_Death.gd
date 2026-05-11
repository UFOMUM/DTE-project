extends Label





	


func _on_area_2d_mouse_shape_exited(shape_idx: int) -> void:
	get_tree().change_scene_to_file("res://Game_Over_(Real).tscn")
