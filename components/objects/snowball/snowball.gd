extends RigidBody2D

var direction : Vector2

export(float) var speed = 1000

# Once added to the scene tree, function will immediately start moving
func _ready():
	apply_impulse(Vector2(), direction.normalized() * speed)


# Call this function before adding the instance to the tree
# Given a point, will launch snowball towards that point
func set_direction(target : Vector2, radius : float = -100):
	if (radius == -100):
		direction = target - get_transform().get_origin()
		direction = direction.normalized()
	else:
		pass

#func _input(event):
#	if event is InputEventKey and event.scancode == KEY_SPACE:
#		if event.is_pressed() and not event.is_echo():
#			print('fire')
#			set_direction(get_transform().get_origin() + Vector2(200,0))
#			print(direction)
#			apply_impulse(Vector2(), direction.normalized() * speed)
			


func _on_other_area_entered(other : Area2D):
	queue_free()
#	if(other.get_tree()):
#		print(other.get_tree())
#		pass
#	else:
#		print(other.get_tree())
#		queue_free()
