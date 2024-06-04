extends Area3D

@export var parentRef : NodePath
@onready var parent = get_node(parentRef)
@export var groupName : String

func _ready():
	set_collision_mask_value(parent.interactionMask,true)
func _on_body_entered(body):
	if body.is_in_group(groupName):
		parent.body = body
		parent.InteractionOn()
func _on_body_exited(body):
	if body.is_in_group(groupName):
		parent.InteractionOff()
