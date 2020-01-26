extends Node
export (PackedScene) var bullet

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var bb = bullet.instance();
	add_child(bb);
	bb.start_at(0, Vector2(100, 100));
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
