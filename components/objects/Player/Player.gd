extends KinematicBody2D

var sound1 = AudioStreamPlayer.new()
var speed = 0
var timer = 0
var in_range = 0
var cool_down = 0
var temp  = 0;
var motion = Vector2()
export var max_snowballcount = 3
export var init_snowballcount = 3
var snowballcount
export (PackedScene) var bullet
export (PackedScene) var aim
export (String) var nametag
onready var firepoint = get_node("firepoint")

var canInteract = false
var interactable = null
var hasSnow = false
var full_ammo

func _ready():
	self.add_child(sound1)
	sound1.stream = load("res://catched.mp3")
	sound1.play()
	snowballcount = init_snowballcount
	
	if snowballcount >= max_snowballcount:
		full_ammo = true
	else:
		false

func add_snowballcount(amount):
	snowballcount += amount
	if snowballcount > max_snowballcount:
		full_ammo = true
		var overflow = max_snowballcount - snowballcount
		snowballcount = max_snowballcount
		return overflow


	return 0
	
func get_snowballcount():
	return snowballcount
	
func get_max_snowballcount():
	return max_snowballcount

func _physics_process(delta):
	in_range -= 1
	cool_down -= 1
	temp -= 1
	var bb;
	motion.x = 0
	motion.y = 0
	
	if Input.is_action_pressed("W"+nametag):
		motion.y += -200
	if Input.is_action_pressed("S"+nametag):
		motion.y += 200
	if Input.is_action_pressed("A"+nametag):
		motion.x += -200
	if Input.is_action_pressed("D"+nametag):
		motion.x += 200
	
	
	if motion != Vector2(0,0):
		set_rotation(atan2(motion.y, motion.x))
		
	
	if (Input.is_action_just_pressed("catch"+nametag) and in_range > 0 and cool_down <= 0):
		in_range = 0
		snowballcount += 1
		sound1.play()
		pass
	
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
	update()
	
	if Input.is_action_just_released("shoot"+nametag) and snowballcount > 0:
		snowballcount -= 1
		full_ammo = false
		cool_down = 100
		bb = bullet.instance()
		firepoint.add_child(bb)
		bb.position = position
		bb.set_direction(get_global_mouse_position())
		bb._ready()
		
	
	# Interacting with object
	if Input.is_action_just_pressed("interact"+nametag):
		# If interaction is possible, call interaction on interactable object
		if canInteract:
			interactable.interact()
			print_debug(snowballcount)
	
func _draw():
	var bb
	if Input.is_action_pressed("shoot"+nametag) and snowballcount > 0:
		bb = aim.instance()
		firepoint.add_child(bb)
		bb.position = position
		bb.set_direction(get_global_mouse_position())
		bb._ready()
		temp = 10;
#		draw_line(Vector2 (0, 0), firepoint.get_child(0).position, Color(255,0,0), 10)

func _on_snowball_enter(area : Area2D):
	# If area detected is on Layer 5 = Bit 4 = 2^4 = 16 (Generator Layer), then turn on interaction
	if area.collision_layer == 16:
		interactable = area.get_parent()
		canInteract = true
	else:
		in_range = 100

func _on_Area2D_area_exited(area):
	canInteract = false
