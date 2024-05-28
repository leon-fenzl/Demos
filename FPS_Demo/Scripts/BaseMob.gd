extends CharacterBody3D
class_name BaseMob
enum AI_TYPES {GUARD,MOB}
enum MOVE_TYPES{WALK,ATK,DEAD}
@export var playerRef : NodePath
@onready var player := get_node(playerRef)
@export var SPEED :float
@export var baseType = AI_TYPES.GUARD
@onready var moveState = MOVE_TYPES.WALK

@onready var agent := $NavigationAgent3D

@onready var gravityVector = ProjectSettings.get_setting("physics/3d/default_gravity_vector")

@onready var new_direction := Vector3.ZERO
func _ready():
	Update_target_location(player.global_position)
func _physics_process(delta):
	GravitySystem(delta)
	Update_target_location(player.global_position)
	velocity = new_direction
	velocity += gravityVector
	move_and_slide()
func CalcualteDirection(d:float):
	new_direction = (agent.get_next_path_position() - global_position).normalized() * SPEED * d
func GravitySystem(DELTA:float):
	if !is_on_floor():
		gravityVector *= 100 * DELTA
	else:
		gravityVector = -get_floor_normal()
func Update_target_location(location:Vector3):
	agent.set_target_position(location)
func _on_location_timer_timeout():
	CalcualteDirection(get_physics_process_delta_time())
func AnimatorController():
	pass
func ATTACK(body:Node=null):
	pass
func TakeDamage(dmg:int):
	pass
func Death():
	queue_free()

