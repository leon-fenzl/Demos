extends BaseMob
class_name FlyingMob
@onready var new_direction := Vector3.ZERO
@onready var height_Pos := Vector3.ZERO
@onready var ray := $RayCast3D
@onready var groundDistance := Vector3.ZERO
@export var minGroundDist := 10.0
func _ready():
	height_Pos = global_position
func _physics_process(delta):
	match moveState:
		MOVE_TYPES.MOVE:
			RotateRaycastRelative()
			Recalculate_Height(delta)
			look_at(player.global_position,Vector3.UP)
			global_position = new_direction + height_Pos
		MOVE_TYPES.ATK:
			pass
		MOVE_TYPES.SUCKED:
			global_position = lerp(global_position,holdPosition,10*delta)
			look_at(bullet_direction,Vector3.UP)
		MOVE_TYPES.BULLET:
			BeLaunched(delta)
			move_and_slide()
func Recalculate_Height(DELTA:float):
	groundDistance  = global_position - (ray.get_collision_normal()*-1)
	if groundDistance.length() <= minGroundDist:
		height_Pos = lerp(height_Pos,groundDistance,10*DELTA)
func GravitySystem(DELTA:float):
	if !is_on_floor():
		gravityVector *= 100 * DELTA
	else:
		gravityVector = Vector3.ZERO
func RotateRaycastRelative():
	ray.rotation.x = -rotation.x
func _on_location_timer_timeout():
	pass # Replace with function body.
func _on_area_sight_body_entered(body):
	if body.is_in_group("mob") and body.moveState.BULLET:
		TakeDamage(body.bullet_damage)
