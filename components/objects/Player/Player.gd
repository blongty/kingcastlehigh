extends KinematicBody2D

var speed = 0
var pos = Vector2()
var motion = Vector2()
var snowballcount = 1;
export (PackedScene) var bullet
export (String) var nametag
onready var firepoint = get_node("firepoint")

func _physics_process(delta):
	var bb;
	
	if Input.is_action_pressed("W"+nametag):
		rotation_degrees = 0
		motion.y = -200
	elif Input.is_action_pressed("S"+nametag):
		rotation_degrees = 180
		motion.y = 200
	elif Input.is_action_pressed("A"+nametag):
		rotation_degrees = 270
		motion.x = -200
	elif Input.is_action_pressed("D"+nametag):
		rotation_degrees = 90
		motion.x = 200
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
	
	pos = global_position
	update()
	
	if Input.is_action_just_released("shoot"+nametag) and snowballcount > 0:
		snowballcount -= 1
		bb = bullet.instance()
		firepoint.add_child(bb)
		bb.position = position
		bb.set_direction(get_global_mouse_position())
		bb._ready()
		
	pass
	
func _on_snowball_enter(area : Area2D):
	queue_free()
	
func _draw():
	if Input.is_action_pressed("shoot"+nametag) and snowballcount > 0:
		draw_line(Vector2(0, 0), get_local_mouse_position(), Color(0,255,0), 10)