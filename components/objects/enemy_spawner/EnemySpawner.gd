extends Node2D

# Declare member variables here. Examples:
export(Array, Array, String) var EnemyWaves = [["NE", "NE", "NE", "NE"]]
var CurrentWave = []
var wave_num = 1
export var wave_delay = 5
export var enemy_delay = 0.5
var NormalEnemy = preload("res://components/objects/enemies/Enemy.tscn")
var FollowPath = preload("res://levels/path_follownode/follow.tscn")

signal wave_clear
signal stage_clear

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#spawn_next_wave()
#	$tick.set_wait_time(wave_delay)
#	($tick as Timer).connect("timeout", self, "_on_wave_timeout")
#	$tick.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func spawn_this(TypeName):
	if TypeName == "NE":
		var node = NormalEnemy.instance()
		var path = FollowPath.instance()
		
		CurrentWave.append(node)
		node.connect("enemy_has_died", self, "_on_enemy_died")
		
		add_child(path)
		path.add_enemy(node)
		#print("spawn a enemy.")

func spawn_next_wave():
	var to_spawn = EnemyWaves.pop_front()
	print("now spawning...")
	print(to_spawn)
	for enemy_name in to_spawn:
		yield(get_tree().create_timer(enemy_delay),"timeout")
		spawn_this(enemy_name)
		
	
func _on_wave_timeout():
	spawn_next_wave()
	if true: # the next spawn condition is met
		wave_num += 1
		if wave_num <= len(EnemyWaves):
			$tick.set_wait_time(wave_delay)
			$tick.set_one_shot(true)
			$tick.start()


func _on_enemy_died(enemy):
	CurrentWave.erase(enemy)
	if EnemyWaves.empty() and CurrentWave.empty():
		emit_signal("stage_clear")
	elif CurrentWave.empty():
		emit_signal("wave_clear")
