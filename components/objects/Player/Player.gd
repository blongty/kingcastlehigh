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
export (int) var player_id
#export (float, 0, 1, .01) var axis_deadzone
onready var firepoint = get_node("firepoint")

var canInteract = false
var interactable = null
var hasSnow = false
var full_ammo
var last_motion = Vector2(200, 0)
export (float) var deadzone = .2
export (int) var move_speed = 400

func _ready():
	#add_child(aim.instance())
	self.add_child(sound1)
	sound1.stream = load("res://catched.mp3")
	sound1.play()
	snowballcount = init_snowballcount
	
	if snowballcount >= max_snowballcount:
		full_ammo = true
	else:
		full_ammo = false

func _physics_process(delta):
	in_range -= 1
	cool_down -= 1
	temp -= 1
	var bb;
	
	# Movement
	# 	Moving requires joystick input beyond deadzone. Due to InputMap limitations, unable to
	# 	get deadzohne, so manually adjust it in edior when changed in InputMap. Also handles keys.
	motion.x = 0
	motion.y = 0
	
	if moving_at_all():
		motion.y -= move_speed * Input.get_action_strength("MOVE_UP")
		motion.y += move_speed * Input.get_action_strength("MOVE_DOWN")
		motion.x -= move_speed * Input.get_action_strength("MOVE_LEFT")
		motion.x += move_speed * Input.get_action_strength("MOVE_RIGHT")	
	move_and_slide(motion);
	
	# Rotation
	if motion != Vector2(0,0):
		set_rotation(atan2(motion.y, motion.x))
	
	# Draws trajectory of snowballs when SHOOT* is held down
	if snowballcount > 0:
		if Input.is_action_pressed("SHOOT") or Input.is_action_pressed("SHOOT_BY_MOUSE"):
			draw_trajectory()
	
	# Placeholder
	if (Input.is_action_just_pressed("CATCH") and in_range > 0 and cool_down <= 0):
		in_range = 0
		snowballcount += 1
		sound1.play()
		pass
	
	# When releasing SHOOT* button, fires a snowball into the scene.
	# 	Will aim with the right analog stick, though when centered within deadzones
	#	it will fire in current direction. If mouse will fire at mouse.
	#	With limitations of Input object, we must create another InputEventAction
	#	that seperates regular SHOOT and SHOOT_BY_MOUSE
	if Input.is_action_just_released("SHOOT") or Input.is_action_just_released("SHOOT_BY_MOUSE"):
		if snowballcount > 0:
			full_ammo = false
			#cool_down = 100
			bb = bullet.instance()
			bb.position = position
			
			if using_r_stick():
				bb.set_direction_offset(Vector2(Input.get_joy_axis(get_player_id(), JOY_AXIS_2), Input.get_joy_axis(get_player_id(), JOY_AXIS_3)))
			elif !using_r_stick() and not Input.is_action_just_released("SHOOT_BY_MOUSE"):
				if motion != Vector2.ZERO:
					bb.set_direction_offset(motion)
					last_motion = motion
				else:
					bb.set_direction_offset(last_motion)
			elif Input.is_action_just_released("SHOOT_BY_MOUSE"):
				bb.set_direction_absolute(get_global_mouse_position())
							
			# Add snowball to scene and fire
			get_tree().get_root().add_child(bb)
			snowballcount -= 1
	
	if (Input.is_action_just_released("SHOOT_BY_MOUSE") and Input.is_action_just_released("SHOOT")):
		print(Input.is_action_just_released("SHOOT_BY_MOUSE"))
	
	# Interacting with object
	if Input.is_action_just_pressed("INTERACT"):
		if canInteract:
			interactable.interact()
			#print_debug(snowballcount)

func draw_trajectory():
	# Create an aim object at this object's current position
	# Also passes to the aim object it's prefered direction, checking 
	# to see if using analog or just mouse
	var bb
	bb = aim.instance()
	bb.position = position
	
	if using_r_stick():
		bb.set_direction_offset(Vector2(Input.get_joy_axis(get_player_id(), JOY_AXIS_2), Input.get_joy_axis(get_player_id(), JOY_AXIS_3)))
	elif not using_r_stick() and not Input.is_mouse_button_pressed(BUTTON_LEFT):
		if motion != Vector2.ZERO:
			bb.set_direction_offset(motion)
			last_motion = motion
		else:
			bb.set_direction_offset(last_motion)
	elif Input.is_mouse_button_pressed(BUTTON_LEFT):
		bb.set_direction_absolute(get_global_mouse_position())
	
	# Adds to the scene and draws it
	get_tree().get_root().add_child(bb)
	print_tree_pretty()

func _on_snowball_enter(area : Area2D):
	# If area detected is on Layer 5 = Bit 4 = 2^4 = 16 (Generator Layer), then turn on interaction
	if area.collision_layer == 16:
		interactable = area.get_parent()
		canInteract = true
	else:
		in_range = 100

func _on_Area2D_area_exited(area):
	canInteract = false

func add_snowballcount(amount):
	snowballcount += amount
	if snowballcount > max_snowballcount:
		full_ammo = true
		var overflow = max_snowballcount - snowballcount
		snowballcount = max_snowballcount
		return overflow

	return 0

func get_player_id():
	return player_id
	
func get_player_id_str():
	return str(player_id)

func get_snowballcount():
	return snowballcount
	
func get_max_snowballcount():
	return max_snowballcount

func using_r_stick():
	# Though inaccurate, this function actually checks to see if satisfies
	# deadzone of right joystick inputs. "Works".
	return Input.is_action_pressed("AIM_UP") or \
		  Input.is_action_pressed("AIM_DOWN") or \
		  Input.is_action_pressed("AIM_LEFT") or \
		  Input.is_action_pressed("AIM_RIGHT")	

func moving_at_all():
	return Input.is_action_pressed("MOVE_UP") or \
		Input.is_action_pressed("MOVE_DOWN") or \
		Input.is_action_pressed("MOVE_LEFT") or \
		Input.is_action_pressed("MOVE_RIGHT")
