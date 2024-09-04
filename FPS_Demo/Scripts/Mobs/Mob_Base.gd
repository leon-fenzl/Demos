extends CharacterBody3D
class_name Mob_Base
#				0		1	2		3
enum MOVE_TYPES{MOVE,SUCKED,BULLET}
@export var moveState = MOVE_TYPES.MOVE
enum AI_LVL {ONE,TWO,THREE,FOUR,FIVE}
@export var aiLvl = AI_LVL.ONE
enum BULLET_TYPE {TYPE_1,TYPE_2,TYPE_3,TYPE_4,TYPE_5}
@export var bulletType = BULLET_TYPE.TYPE_1
#
@export var playerRef : NodePath
@onready var player := get_node(playerRef)
@export var life := 0.0
@export var mob_damage := 0.0
@export_range(0.1,1.0,0.1) var dmgCtrl : float
@export var SPEED : float
@onready var distanceToPlayer := Vector3.ZERO
@export var minAtkDistance := 5.0
#
@onready var bullet_sight := $Bullet_Sight
#@onready var bodies : Array
#
@onready var gravityVector = ProjectSettings.get_setting("physics/3d/default_gravity_vector")
@onready var holdPosition := Vector3.ZERO
@export var bullet_speed := 10.0
@onready var playerVelocity := Vector3.ZERO
func Set_Mob_LVL():
	match aiLvl:
		AI_LVL.ONE:
			pass
		AI_LVL.TWO:
			pass
		AI_LVL.THREE:
			pass
		AI_LVL.FOUR:
			pass
		AI_LVL.FIVE:
			pass
func CalculateDistanceToPlayer():
	distanceToPlayer = player.global_position - global_position
func Anim_Controller():
	pass
func On_Sucktion(DELTA:float):
	global_position = lerp(global_position,holdPosition,10*DELTA)
func BeLaunched(DELTA:float):
	velocity += -transform.basis.z+playerVelocity*DELTA
func Take_Damage(dmg:float):
	life -= dmg * dmgCtrl
	print(life)
	if life <= 0.5:
		Death()
func Bullet_Attack():
	if bullet_sight.is_colliding():
		if bullet_sight.get_collider().is_in_group("mobs"):
			bullet_sight.get_collider().Take_Damage(mob_damage)
			Death()
		else:
			Death()
func Death():
	queue_free()
