extends General_Physics_Body
class_name PushDrag
@onready var body : Node
func _physics_process(delta):
	BePushed(delta)
	Custom_Gravity(delta)
	velocity = gravity + PUSHED
	move_and_slide()
