extends Timer

func _on_timeout():
	$"..".bake_navigation_mesh()
