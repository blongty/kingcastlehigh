extends Node2D


onready var start_pos = get_node("start point")
onready var end_pos = get_node("end point")
onready var nav = get_node("Navigation2D")

func _ready():
	var path = $Navigation2D.get_simple_path(start_pos.position,end_pos.position)
	$Player.path = path

	
