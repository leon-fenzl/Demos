extends CharacterBody3D
class_name BaseMob
#				0		1	2		3
enum MOVE_TYPES{MOVE,SUCKED,BULLET}
@export var moveState = MOVE_TYPES.MOVE
enum AI_TYPES {EXPLOSIVE,FLYING}
@export var baseType = AI_TYPES.EXPLOSIVE
#
@export var playerRef : NodePath
@onready var player := get_node(playerRef)
@export var life := 0.0
@export var mob_damage := 0.0
@export_range(0.1,1.0,0.1) var lifePercentage :float
@export var SPEED :float
@onready var canAtk:=false
#@onready var target:Node
@onready var gravityVector = ProjectSettings.get_setting("physics/3d/default_gravity_vector")
@onready var holdPosition := Vector3.ZERO
@onready var distanceToPlayer := Vector3.ZERO
@onready var atkDistance := 5.0
@export var bullet_damage := 0.0
@export var bullet_speed := 10.0
@export var bullet_direction := Vector3.ZERO
@onready var playerVelocity := Vector3.ZERO
func SetLife():
	life = mob_damage
func CalculateDistanceToPlayer():
	distanceToPlayer = player.global_position - global_position
func AttackOnSight(ray:Node,dmg:float):
	match moveState:
		MOVE_TYPES.MOVE:
			distanceToPlayer = player.global_position - global_position
			if distanceToPlayer.length() <= atkDistance and ray.is_colliding():
				ray.get_collider().TakeDamage(dmg)
		MOVE_TYPES.BULLET:
			if ray.is_colliding():
				ray.get_collider().TakeDamage(dmg)
				Death()
func AnimatorController():
	pass
func TakeDamage(dmg:=0):
	life -= dmg * lifePercentage
	if life <= 0.5:
		Death()
func OnSucktion(DELTA:float):
	global_position = lerp(global_position,holdPosition,10*DELTA)
func BeLaunched(DELTA:float):
	velocity += -transform.basis.z+playerVelocity*DELTA
func Death():
	queue_free()
