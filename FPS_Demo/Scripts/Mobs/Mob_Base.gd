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
@export_group("MOB Base Values")
@onready var player : Node
@export var life := 0.0
@export var mob_damage := 0.0
@export_range(0.1,1.0,0.1) var dmgCtrl : float
@export var SPEED : float
@onready var distanceToPlayer := Vector3.ZERO
@export var minAtkDistance := 5.0
@export_group("Bullet Behaviour")
@export var bullet_speed := 500.0
@onready var bullet_sight := $Shape_Sight
@onready var bullet_target : Node
@onready var bullet_target_normal := Vector3.ZERO
#
@onready var gravityVector = ProjectSettings.get_setting("physics/3d/default_gravity_vector")
@onready var holdPosition := Vector3.ZERO
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
func Take_Damage(dmg:float):
	life -= dmg * dmgCtrl
	if life <= 0.5:
		Death()
func Bh_Bullet(DELTA:float):
	velocity += -transform.basis.z*bullet_speed*DELTA
	if bullet_sight.is_colliding():
		if bullet_sight.get_collider(0).is_in_group("mobs"):
			bullet_sight.get_collider(0).Take_Damage(mob_damage)
			print(bullet_sight.get_collider(0))
			Death()
		else:
			Death()
func Within_Sight_Area(parent:Node,body:Node):
	if parent.moveState == MOVE_TYPES.BULLET:
		if body.is_in_group("mobs"):
			body.Take_Damage(mob_damage)
		if  body.is_on_floor() || body.is_on_wall():
			Death()
func Death():
	print( name + " has died")
	queue_free()
