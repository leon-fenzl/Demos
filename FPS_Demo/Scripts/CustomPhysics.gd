extends CharacterBody3D
class_name General_Physics_Body

@onready var col = KinematicCollision3D
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
		if get_slide_collision(i).get_collider() is RigidBody3D:
			col = get_slide_collision(i)
			PushRigids()
func PushRigids():
	if col.get_collider() is RigidBody3D:
		col.get_collider().apply_central_force(-col.get_normal()*1000)
func PushKinematics(DELTA:float):
	for i in get_slide_collision_count():
		if get_slide_collision(i).get_collider() is CharacterBody3D:
			col = get_slide_collision(i)
			print(col.get_normal())
			col.get_collider().velocity.x += -col.get_normal().x * 1000.0 * DELTA
			col.get_collider().velocity.z += -col.get_normal().z * 1000.0 * DELTA
func BePushed(DELTA:float):
	for i in get_slide_collision_count():
		if get_slide_collision(i).get_collider() is CharacterBody3D:
			print(col.get_normal())
			col = get_slide_collision(i)
			PUSHED.x += -col.get_normal().x * 1000.0 * DELTA
			PUSHED.z += -col.get_normal().z * 1000.0 * DELTA
