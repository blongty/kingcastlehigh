extends Node2D

signal im_hurt


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_im_hurt(area):
	if area.collision_layer == 4:
		print("owie, enemy hurt me")
		emit_signal("im_hurt")
