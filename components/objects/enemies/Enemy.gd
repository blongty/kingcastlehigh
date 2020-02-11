extends Node2D

class_name Enemy
export(int) var life = 1

signal enemy_has_died

# Called when the node enters the scene tree for the first time.
func _ready():
	($Anim as AnimationPlayer).play("Flicker")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_snowball_enter(area : Area2D):
	if area.collision_layer == 2 or area.collision_layer == 128:
		life -= 1
	if life <= 0:
		emit_signal("enemy_has_died", self)
		queue_free()
