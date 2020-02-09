extends RigidBody2D

var direction : Vector2
var life = 1

export(float) var speed = 1000
var pid_owner

# Once added to the scene tree, function will immediately start moving
func _ready():
	apply_impulse(Vector2(), direction.normalized() * speed)


# Call this function before adding the instance to the tree
# Given a point, will launch snowball towards that point
func set_direction_absolute(target : Vector2, radius : float = -100):
	if (radius == -100):
		direction = target - get_transform().get_origin()
		direction = direction.normalized()

func set_direction_offset(offset: Vector2, radius: float = -100):
	direction = offset
	direction = direction.normalized()

#func _input(event):
#	if event is InputEventKey and event.scancode == KEY_SPACE:
#		if event.is_pressed() and not event.is_echo():
#			print('fire')
#			set_direction(get_transform().get_origin() + Vector2(200,0))
#			print(direction)
#			apply_impulse(Vector2(), direction.normalized() * speed)
			

func _on_other_area_entered(other : Area2D):
	life -= 1
	if (life < 0):
		queue_free()
		
func get_pid_owner():
	return pid_owner
