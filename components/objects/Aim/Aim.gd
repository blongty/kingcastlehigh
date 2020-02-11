extends RigidBody2D

var direction : Vector2
var life = 1

export(float) var speed = 5000
var pid_owner

# Once added to the scene tree, function will immediately start moving
func _ready():
	apply_impulse(Vector2(), direction.normalized() * speed)
	#apply_impulse(Vector2(), Vector2(1, 0) * speed)
	


# Call this function before adding the instance to the tree
# Given a point, will launch snowball towards that point
func set_direction_absolute(target : Vector2, radius : float = -100):
	if (radius == -100):
		direction = target - get_transform().get_origin()
		direction = direction.normalized()
	else:
		pass
		
func set_direction_offset(offset: Vector2, radius: float = -100):
	direction = offset
	direction = direction.normalized()

func _process(delta):
	pass

func _on_other_area_entered(other : Area2D):
	if other.collision_layer == 16:
		return
	elif other.collision_layer == 1:
		if other.get_parent().get_player_id() == get_pid_owner():
			return
	life -= 1
	if (life <= 0):
		queue_free()

func _on_other_body_entered(other : Node):
	if other.collision_layer == 1:
		if other.get_player_id() == get_pid_owner():
			return
	life -= 1
	if (life <= 0):
		queue_free()

func _on_Timer_timeout():
	queue_free()

func get_pid_owner():
	return pid_owner
