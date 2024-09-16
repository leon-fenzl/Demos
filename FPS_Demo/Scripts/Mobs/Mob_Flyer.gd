extends Mob_Base
class_name Mob_Flyer
@onready var new_direction := Vector3.ZERO
@onready var height_Pos := Vector3.ZERO
@onready var rayG := $RayGround
@onready var groundDistance := Vector3.ZERO
@export var max_GroundDist := 10.0
@onready var move_direction := Vector3.ZERO
func _ready():
	height_Pos = global_position
	moveState = MOVE_TYPES.MOVE
func _physics_process(delta):
	match moveState:
		MOVE_TYPES.MOVE:
			Relative_Rotation_GroundRay()
			Recalculate_Height(delta)
			Fly_To_Player(delta)
			velocity = move_direction + height_Pos
			move_and_slide()
			look_at(player.global_position)
			Mob_Attack()
		MOVE_TYPES.SUCKED:
			On_Sucktion(delta)
		MOVE_TYPES.BULLET:
			Bh_Bullet(delta)
			move_and_slide()
func Recalculate_Height(DELTA:float):
	groundDistance = rayG.get_collision_point() - global_position + Vector3.UP*5
	if groundDistance.length() < max_GroundDist:
		height_Pos += groundDistance * SPEED * DELTA
	#if groundDistance.length() >= max_GroundDist:
	else:height_Pos = Vector3.UP * 2
func Relative_Rotation_GroundRay():
	rayG.rotation.x = -rotation.x
func Fly_To_Player(DELTA:float):
	distanceToPlayer.x = player.global_position.x - global_position.x
	distanceToPlayer.z = player.global_position.z - global_position.z
	if distanceToPlayer.length() >= minAtkDistance:
		move_direction = lerp(move_direction,distanceToPlayer*SPEED*DELTA,24.0 * DELTA)
	else:
		move_direction = Vector3.ZERO
func Mob_Attack():
	pass
