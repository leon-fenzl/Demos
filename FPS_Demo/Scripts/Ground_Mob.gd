extends BaseMob
class_name GroundMob
@onready var new_direction := Vector3.ZERO
@onready var agent := $NavigationAgent3D
@onready var rayS := $Ray_Sight
func _ready():
	moveState = MOVE_TYPES.MOVE
	Update_target_location(player.global_position)
func _on_location_timer_timeout():
	CalcualteDirection(get_physics_process_delta_time())
func _physics_process(delta):
	AttackOnSight(rayS,bullet_damage)
	match moveState:
		MOVE_TYPES.MOVE:
			GravitySystem(delta)
			look_at(Vector3(player.global_position.x,global_position.y,player.global_position.z),Vector3.UP)
			Update_target_location(player.global_position)
			velocity = new_direction
			velocity += gravityVector
			move_and_slide()
		MOVE_TYPES.SUCKED:
			OnSucktion(delta)
		MOVE_TYPES.BULLET:
			BeLaunched(delta)
			move_and_slide()
func GravitySystem(DELTA:float):	
	if !is_on_floor():
		gravityVector *= 100 * DELTA
	else:
		gravityVector = -get_floor_normal()
func CalcualteDirection(d:float):
	new_direction = (agent.get_next_path_position() - global_position).normalized() * SPEED * d
func Update_target_location(location:Vector3):
	agent.set_target_position(location)
