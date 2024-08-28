extends RigidBody3D
class_name BaseRigidbody

@onready var gravity := Vector3.ZERO

@onready var groundCheck := $GroundCheck
@onready var onGround := false
@onready var groundNormal := Vector3.ZERO

@onready var wallCheck:= $WallCheck
@onready var onWall := false
@onready var wallNormal := Vector3.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity_Direction = ProjectSettings.get_setting("physics/3d/default_gravity_vector")

func Gravity(DELTA:float):
	if OnGround() == false:
		gravity += gravity_Direction * 100 * DELTA
	else:
		gravity = -groundCheck.get_collision_normal() * DELTA
func ContactCheck():
	if wallCheck.is_colliding():
		OnWall()
	if groundCheck.is_colliding():
		OnGround()
func OnWall()->bool:
	return true
func OnGround()->bool:
	return true
