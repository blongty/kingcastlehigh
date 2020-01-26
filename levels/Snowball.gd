extends Area2D

var velo = Vector2();
var spee = 5;

func _ready():
	pass

func start_at(dir, pos):
	rotation = dir;
	position = pos;
	velo.x = spee * sin(dir);
	velo.y = spee * -cos(dir);
	pass

func _physics_process(delta):
	position.x += velo.x
	position.y += velo.y
	pass
	
func destroy():
	queue_free()