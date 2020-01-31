extends StaticBody2D

var canInteract = false

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node('InteractionArea2D').connect("body_entered", self, '_on_InteractionArea2D_body_entered')
	get_node('InteractionArea2D').connect("body_exited", self, '_on_InteractionArea2D_body_exited')

# Note: This function assumes that the Area2D is only masked to the player layer
# Turn on interactions if detecting an object from player layer
func _on_InteractionArea2D_body_entered(body):
	canInteract = true
	var infoText = get_node('Label')
	infoText.visible = true

# Note: This function assumes that the Area2D is only masked to the player layer
# Turn off interactions if no longer detecting an object from player layer
func _on_InteractionArea2D_body_exited(body):
	canInteract = false
	var infoText = get_node('Label')
	infoText.visible = false

# Should do something if player presses interaction button and canInteract == TRUE
func interact():
	if canInteract:
		var infoText = get_node('Label')
		infoText.text = 'INTERACTED!'

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
