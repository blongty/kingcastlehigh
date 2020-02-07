extends StaticBody2D

var canInteract = false
var hasSnowball = false
var player = null
export var max_storage = 3
export var init_storage = 3
var storage

# Called when the node enters the scene tree for the first time.
func _ready():
	storage = init_storage
	print("storage starting with " + str(storage) + "snowballs")
	get_node('InteractionArea2D').connect("body_entered", self, '_on_InteractionArea2D_body_entered')
	get_node('InteractionArea2D').connect("body_exited", self, '_on_InteractionArea2D_body_exited')
	get_node('InteractionArea2D').connect("area_entered", self, '_on_InteractionArea2D_area_entered')

# Note: This function assumes that the Area2D is only masked to the player layer
# Turn on interactions if detecting an object from player layer
func _on_InteractionArea2D_body_entered(body):
	canInteract = true
	player = body
	var infoText = get_node('Label')
	infoText.text = 'Press ________ to interact!!'
	infoText.visible = true


# Note: This function assumes that the Area2D is only masked to the player layer
# Turn off interactions if no longer detecting an object from player layer
func _on_InteractionArea2D_body_exited(body):
	canInteract = false
	player = null
	var infoText = get_node('Label')
	infoText.visible = false

func _on_InteractionArea2D_area_entered(area):
	if area.collision_layer == 2:
		storage += 1
		if storage > max_storage:
			storage = max_storage
			

# Should do something if player presses interaction button and canInteract == TRUE
func interact():
	if canInteract:
		var infoText = get_node('Label')
		infoText.text = 'INTERACTED!'
		if !player.full_ammo and !player.hasSnow:
			storage = player.add_snowballcount(storage)
			print("storage has left " + str(storage))
		elif player.hasSnow:
			storage += 1
			player.hasSnow = false
			
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
