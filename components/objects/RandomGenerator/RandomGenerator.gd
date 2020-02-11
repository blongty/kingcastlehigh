extends Node2D

var bb = null
var randomint
var canInteract
var empty = true
export (int) var pp
export (PackedScene) var output

func _process(delta):
	randomint = randi()% pp+ 0
	if (randomint == 1) and not bb :
		print ("a snowpile is randomly generated")
		bb = output.instance()
		bb.position = position
		get_tree().get_root().get_node("Node2D").add_child(bb)
