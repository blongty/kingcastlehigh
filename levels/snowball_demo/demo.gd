extends Node2D

export(PackedScene) var snowball

func _input(event):
	if event is InputEventMouseButton:
		if event.get_button_index() == BUTTON_LEFT and event.is_pressed():
			var node = snowball.instance()
			node.set_direction(get_local_mouse_position())
			add_child(node)