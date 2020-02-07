extends StaticBody2D
var CanInteract = false
var player = null

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node('Area2D').connect("body_entered",self,'_on_Area2D_body_entered')
	get_node('Area2D').connect("body_exited",self,'_on_Area2D_body_exited')
	
func _on_Area2D_body_entered(body):
	CanInteract = true
	player = body
	var infoText = get_node('Label')
	infoText.visible = true

func _on_Area2D_body_exited(body):
	CanInteract = false
	player = null
	var infoText = get_node('Label')
	infoText.visible = false

func interact():
	if CanInteract:
		var infoText = get_node('Lable')
		infoText.text = 'Get Snow!'
		if player.hasSnow == false:
			player.hasSnow = true
		
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
