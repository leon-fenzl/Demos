extends CharacterBody3D
class_name BaseMob
enum AI_TYPES {GROUND,FLYING}
#				0		1	2	3
enum MOVE_TYPES{MOVE,ATK,SUCKED,BULLET}
@export var baseType = AI_TYPES.GROUND
@export var moveState = MOVE_TYPES.MOVE
@export var playerRef : NodePath
@onready var player := get_node(playerRef)
#
@export var life := 0.0
@export var mob_damage := 0.0
@export_range(0.1,1.0,0.1) var lifePercentage :float
@export var SPEED :float
@onready var canAtk:=false
@onready var target:Node
#
@onready var gravityVector = ProjectSettings.get_setting("physics/3d/default_gravity_vector")
#
@onready var holdPosition := Vector3.ZERO
@onready var distanceToPlayer := Vector3.ZERO
#
@export var bullet_damage := 0.0
@export var bullet_speed := 500.0
@export var bullet_direction := Vector3.ZERO
@onready var playerVelocity := Vector3.ZERO

func CalculateDistanceToPlayer():
	distanceToPlayer = player.global_position - global_position
func AnimatorController():
	pass
func TakeDamage(dmg:=0):
	life -= dmg * lifePercentage
	if life <= 0.5:
		Death()
func BeLaunched(DELTA:float):
	velocity += -transform.basis.z+playerVelocity*bullet_speed*0.1*DELTA
func Death():
	queue_free()
