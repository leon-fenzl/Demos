extends CharacterBody3D
class_name BaseMob
enum AI_TYPES {GUARD,MOB}
#				0		1	2		3	4	
enum MOVE_TYPES{WALK,ATK,SUCKED,BULLET,DEAD}

@export var playerRef : NodePath
@onready var player := get_node(playerRef)

@export var SPEED :float
@export var baseType = AI_TYPES.GUARD

@onready var holdPosition := Vector3.ZERO
@onready var moveState = MOVE_TYPES.WALK
@onready var agent := $NavigationAgent3D
@onready var gravityVector = ProjectSettings.get_setting("physics/3d/default_gravity_vector")
@onready var new_direction := Vector3.ZERO
@onready var pivot := 0.0
@export var bullet_damage := 0.0
@export var bullet_speed := 500.0
@export var bullet_direction := Vector3.ZERO
@onready var playerVelocity := Vector3.ZERO

func _ready():
	Update_target_location(player.global_position)
func _physics_process(delta):
	match moveState:
		MOVE_TYPES.WALK:
			GravitySystem(delta)
			look_at(Vector3(player.global_position.x,global_position.y,player.global_position.z),Vector3.UP)
			Update_target_location(player.global_position)
			velocity = new_direction
			velocity += gravityVector
			move_and_slide()
		MOVE_TYPES.ATK:
			pass
		MOVE_TYPES.SUCKED:
			global_position = lerp(global_position,holdPosition,10*delta)
			look_at(bullet_direction,Vector3.UP)
		MOVE_TYPES.BULLET:
			GravitySystem(delta)
			BeLaunched(delta)
			move_and_slide()
		MOVE_TYPES.DEAD:
			pass
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
func BeLaunched(DELTA:float):
	velocity += playerVelocity + transform.basis.z*-bullet_speed*2*DELTA 
func _on_sight_body_entered(body):
	pass # Replace with function body.
