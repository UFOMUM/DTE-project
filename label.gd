extends Label





	


func _on_area_2d_mouse_shape_exited(shape_idx: int) -> void:
	get_tree().change_scene_to_file("res://max_level.tscn")
