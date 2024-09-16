extends Node
class_name  PlayerAbilities

@onready var parent := $".."
@onready var interact := false

func _physics_process(delta):
	LookAtDirection()
	Suck_Launch(delta)
func LookAtDirection():
	if Input.is_action_pressed("aim"):
		parent.rotation.y = parent.camSystem.rotation.y
	else:
		if parent.move_Input.x != 0.0 || parent.move_Input.z != 0.0:
			parent.look_at(parent.position + parent.move_Input, Vector3.UP)
func Suck_Launch(DELTA:float):
	SetLaunchDirection()
	if Input.is_action_just_pressed("aim") and parent.target == null:
		if parent.camSystem.aimCast.is_colliding() and !parent.camSystem.aimCast.get_collider(0).is_in_group("ground"):
			parent.target = parent.camSystem.aimCast.get_collider(0)
	if Input.is_action_pressed("aim"):
		if parent.target != null:
			parent.target.transform.basis = parent.holder.global_transform.basis
			parent.target.holdPosition = parent.holder.global_position
			if parent.target.moveState != parent.target.MOVE_TYPES.SUCKED:
				parent.target.moveState = parent.target.MOVE_TYPES.SUCKED
	if Input.is_action_just_released("aim") and parent.target != null:
		parent.target.playerVelocity = -parent.velocity
		parent.target.moveState = parent.target.MOVE_TYPES.BULLET
		parent.target = null
func SetLaunchDirection():
	if parent.camSystem.aimCast.is_colliding():
		parent.holder.look_at(parent.camSystem.aimCast.get_collision_point(0),Vector3.UP)
	else:
		parent.holder.look_at(parent.camSystem.pointer.global_position,Vector3.UP)
