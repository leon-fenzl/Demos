extends Node

func _on_area_3d_body_entered(body):
	if body.is_in_group("pushable"):
		body.PUSHED = $"..".velocity
func _on_area_3d_body_exited(body):
	if body.is_in_group("pushable"):
		body.PUSHED = Vector3.ZERO
		body = null
