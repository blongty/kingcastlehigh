extends StaticBody2D

var canInteract = false
var hasSnowball = false
var player = null
export var max_sotrage = 3
export var init_storage = 3
var storage

# Called when the node enters the scene tree for the first time.
func _ready():
	storage = init_storage
	get_node('InteractionArea2D').connect("body_entered", self, '_on_InteractionArea2D_body_entered')
	get_node('InteractionArea2D').connect("body_exited", self, '_on_InteractionArea2D_body_exited')

# Note: This function assumes that the Area2D is only masked to the player layer
# Turn on interactions if detecting an object from player layer
func _on_InteractionArea2D_body_entered(body):
	canInteract = true
	player = body
	var infoText = get_node('Label')
	infoText.visible = true

# Note: This function assumes that the Area2D is only masked to the player layer
# Turn off interactions if no longer detecting an object from player layer
func _on_InteractionArea2D_body_exited(body):
	canInteract = false
	player = null
	var infoText = get_node('Label')
	infoText.visible = false

# Should do something if player presses interaction button and canInteract == TRUE
func interact():
	if canInteract:
		var infoText = get_node('Label')
		infoText.text = 'INTERACTED!'
		if !player.full_ammo:
			storage = player.add_snowballcount(storage)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
