extends Mob_Base
class_name Mob_Flyer
@onready var new_direction := Vector3.ZERO
@onready var height_Pos := Vector3.ZERO
@onready var rayG := $RayGround
@onready var groundDistance := Vector3.ZERO
@export var minGroundDist := 10.0
@onready var sight := $Area_Sight
func _ready():
	height_Pos = global_position
func _physics_process(delta):
	match moveState:
		MOVE_TYPES.MOVE:
			Relative_Rotation_GroundRay()
			Recalculate_Height(delta)
			look_at(player.global_position,Vector3.UP)
			global_position = new_direction + height_Pos
			Mob_Attack()
		MOVE_TYPES.SUCKED:
			On_Sucktion(delta)
		MOVE_TYPES.BULLET:
			Bullet_Attack()
			BeLaunched(delta)
			move_and_slide()
func Recalculate_Height(DELTA:float):
	groundDistance  = global_position - (rayG.get_collision_normal()*-1)
	if groundDistance.length() <= minGroundDist:
		height_Pos = lerp(height_Pos,groundDistance,10*DELTA)
func GravitySystem(DELTA:float):
	if !is_on_floor():
		gravityVector *= 100 * DELTA
	else:
		gravityVector = Vector3.ZERO
func Relative_Rotation_GroundRay():
	rayG.rotation.x = -rotation.x
func _on_location_timer_timeout():
	pass # Replace with function body.body
func Mob_Attack():
	pass
