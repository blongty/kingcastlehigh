extends Node

var enemy_spawner_node
var timer
var ice_king

export(int) var stage_life = 5
export(int) var start_delay = 1
export(int) var delay_between_stage_clear = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	$game_over_screen.hide()
	enemy_spawner_node = find_node("EnemySpawner", true, false)
	ice_king = find_node("IceKing", true, false)
	
	if (enemy_spawner_node == null):
		push_error("ERROR: Scene must have EnemySpawner node")
		print("ERROR: Scene must have EnemySpawner node")
		get_tree().quit()
		
	if (ice_king == null):
		push_error("ERROR: Scene must have Ice_King node")
		print("ERROR: Scene must have Ice_King node")
		get_tree().quit()
	
	timer = Timer.new()
	timer.connect("timeout", self, "_on_timer_timeout")
	
	timer.set_one_shot(true)
	timer.set_wait_time(start_delay)
	add_child(timer)
	timer.start()
	
	enemy_spawner_node.connect("wave_clear", self, "_on_wave_clear")
	enemy_spawner_node.connect("stage_clear", self, "_on_stage_clear")
	
	ice_king.connect("im_hurt", self, "_on_king_hurt")


func _on_timer_timeout():
	enemy_spawner_node.spawn_next_wave()

func _on_wave_clear():
	timer.set_wait_time(delay_between_stage_clear)
	timer.start()

func _on_stage_clear():
	if stage_life > 0:
		print("Stage clear!")
		_show_game_over()
	
func _on_king_hurt():
	stage_life -= 1
	if stage_life <= 0:
		print("Game Over!")
		_show_game_over()
		
func _show_game_over():
	$game_over_screen/button_restart.connect("pressed", self, "_restart")
	$game_over_screen.show()
		
func _restart():
	get_tree().change_scene(get_filename())
	
