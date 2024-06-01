extends CharacterBody3D
class_name General_Physics_Body

var col : KinematicCollision3D
var PUSHING := Vector3.ZERO
var PUSHED := Vector3.ZERO
var PULL := Vector3.ZERO
var TUMBLE := Vector3.ZERO
var ROLL := Vector3.ZERO
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity := Vector3.ZERO
var gravity_Direction = ProjectSettings.get_setting("physics/3d/default_gravity_vector")
func Custom_Gravity(DELTA:=60.0, BASE_WEIGHT := 100.0):
	if !is_on_floor():
		gravity += gravity_Direction * BASE_WEIGHT * DELTA
	else:
		if gravity != -get_floor_normal():
			gravity = -get_floor_normal() * DELTA
func GetCollisions():
	for i in get_slide_collision_count():
		col = get_slide_collision(i)
		col.get_collider()
func PushRigids():
	if col != null:
		if col.get_collider() is RigidBody3D:
			col.get_collider().apply_central_impulse(-col.get_normal()*col.get_collider().mass)
func PushKinematics(DELTA:float):
	if col != null:
		if col.get_collider() is CharacterBody3D:
			col.PUSHED += velocity
func BePushed(DELTA:float):
	if col != null:
		if col.get_collider() is CharacterBody3D:
			PUSHED += -col.get_normal() * 1000.0 * DELTA
