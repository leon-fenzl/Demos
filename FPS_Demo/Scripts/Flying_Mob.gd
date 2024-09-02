extends BaseMob
class_name FlyingMob

@onready var new_direction := Vector3.ZERO
@onready var height_Pos := Vector3.ZERO
@onready var rayG := $Ray_Ground
@onready var rayS := $Ray_Sight
@onready var groundDistance := Vector3.ZERO
@export var minGroundDist := 10.0
func _ready():
	height_Pos = global_position
func _physics_process(delta):
	AttackOnSight(rayS,bullet_damage)
	match moveState:
		MOVE_TYPES.MOVE:
			RelativeRotationGroundRay()
			RecalculateHeight(delta)
			look_at(player.global_position,Vector3.UP)
			global_position = new_direction + height_Pos
		MOVE_TYPES.SUCKED:
			OnSucktion(delta)
		MOVE_TYPES.BULLET:
			BeLaunched(delta)
			move_and_slide()
func RecalculateHeight(DELTA:float):
	groundDistance  = global_position - (rayG.get_collision_normal()*-1)
	if groundDistance.length() <= minGroundDist:
		height_Pos = lerp(height_Pos,groundDistance,10*DELTA)
func GravitySystem(DELTA:float):
	if !is_on_floor():
		gravityVector *= 100 * DELTA
	else:
		gravityVector = Vector3.ZERO
func RelativeRotationGroundRay():
	rayG.rotation.x = -rotation.x
func _on_location_timer_timeout():
	pass # Replace with function body.
