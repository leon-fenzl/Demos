extends CharacterBody3D
class_name General_Physics_Body


var PUSHING := Vector3.ZERO
var PUSHED := Vector3.ZERO
var PULL := Vector3.ZERO
var TUMBLE := Vector3.ZERO
var ROLL := Vector3.ZERO
# Obtenha a Gravidade das configurações do projeto para ser sincronizada com os nós do RigidBody.
# Get the Gravity from the project settings to be synced with RigidBody nodes.
var gravity := Vector3.ZERO
var gravity_Direction = ProjectSettings.get_setting("physics/3d/default_gravity_vector")

func Custom_Gravity(DELTA:=60.0, BASE_WEIGHT := 100.0):
	if !is_on_floor():
		gravity += gravity_Direction * BASE_WEIGHT * DELTA
	else:
		if gravity != -get_floor_normal():
			gravity = -get_floor_normal() * DELTA
#func PushKinematics(DELTA:float):
	#for i in get_slide_collision_count():
		#if get_slide_collision(i).get_collider() is CharacterBody3D:
			#colForKin = get_slide_collision(i)
			#print(colForKin.get_normal())
			#colForKin.get_collider().velocity.x += -colForKin.get_normal().x * 1000.0 * DELTA
			#colForKin.get_collider().velocity.z += -colForKin.get_normal().z * 1000.0 * DELTA
#func BePushed(DELTA:float):
	#for i in get_slide_collision_count():
		#if get_slide_collision(i).get_collider() is CharacterBody3D:
			#print(colForKin.get_normal())
			#colForKin = get_slide_collision(i)
			#PUSHED.x += -colForKin.get_normal().x * 1000.0 * DELTA
			#PUSHED.z += -colForKin.get_normal().z * 1000.0 * DELTA
