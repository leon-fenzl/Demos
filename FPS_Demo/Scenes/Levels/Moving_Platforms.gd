extends Node3D

enum PLATFORM_TYPES {ATOB,ROT_X,ROT_Y,ROT_Z}
@export var platform := PLATFORM_TYPES.ATOB
enum MATERIAL_TYPES {WOOD,METAL,GROUND}
@export var mat_type := MATERIAL_TYPES.WOOD
@export var rot_speed := 5.0
func _physics_process(delta):
	match platform:
		PLATFORM_TYPES.ATOB:
			MOVE_FROM_TO()
		PLATFORM_TYPES.ROT_X:
			ROT_X(delta)
		PLATFORM_TYPES.ROT_Y:
			ROT_Y(delta)
		PLATFORM_TYPES.ROT_Z:
			ROT_Z(delta)
func MOVE_FROM_TO():
	pass
func ROT_X(DELTA:float):
	rotation.x += rot_speed * DELTA
func ROT_Y(DELTA:float):
	rotation.y += rot_speed * DELTA
func ROT_Z(DELTA:float):
	rotation.z += rot_speed * DELTA
