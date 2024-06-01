extends General_Physics_Body

func _physics_process(delta):
	Custom_Gravity(delta)
	velocity = gravity + PUSHED
	move_and_slide()
