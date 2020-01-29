extends KinematicBody2D

var speed = 0
var motion = Vector2()
var snowballcount = 1;
export (PackedScene) var bullet
onready var firepoint = get_node("firepoint")

func _physics_process(delta):
	var bb;
	
	if Input.is_action_pressed("W"):
		rotation_degrees = 0
		motion.y = -20
	elif Input.is_action_pressed("S"):
		rotation_degrees = 180
		motion.y = 20
	elif Input.is_action_pressed("A"):
		rotation_degrees = 270
		motion.x = -20
	elif Input.is_action_pressed("D"):
		rotation_degrees = 90
		motion.x = 20
	else:
		motion.x = 0
		motion.y = 0
	
#	if Input.is_action_pressed("ui_up"):
#		speed = -200;
#	elif Input.is_action_pressed("ui_down"):
#		speed = 200;
#	else:
#		speed = 0;

#	if Input.is_action_pressed("ui_right"):
#		rotation += 0.1;
#	elif Input.is_action_pressed("ui_left"):
#		rotation += -0.1;
	
#	motion.x = speed * -sin(rotation);
#	motion.y = speed * cos(rotation);
	move_and_slide(motion);
	
	if Input.is_action_pressed("ui_select") and snowballcount > 0:
		snowballcount -= 1;
		bb = bullet.instance();
		firepoint.add_child(bb);
	pass