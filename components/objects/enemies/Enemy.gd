extends Node2D

class_name Enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	($Anim as AnimationPlayer).play("Flicker")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_snowball_enter(area : Area2D):
	queue_free()
