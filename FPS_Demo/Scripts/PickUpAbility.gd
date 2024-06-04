extends Node
class_name  PlayerAbilities

@onready var parent := $".."
@onready var interact := false
@onready var body : Node3D

func _physics_process(delta):
	Interact()
func Interact() -> bool:
	if Input.is_action_pressed("actionOne"):
		return true
	else:
		return false
func _on_sight_body_entered(body):
	pass # Replace with function body.
func _on_sight_body_exited(body):
	pass # Replace with function body.
