extends General_Physics_Body
class_name Player
#
@export var camRef : NodePath
@onready var camSystem = get_node(camRef)
#
@export var life := 10.0
@export_range(0.1,1.0,0.1) var dmg_ctrl :float
@export var speed := 5.0
@export var jumpForce := 4.5
@onready var move_Input := Vector3.ZERO
@onready var move_direction := Vector3.ZERO
@onready var jumpVector := Vector3.ZERO
@onready var canAtk := false
#
@onready var abilities := $PlayerAbilities
@onready var holder := $Marker3D
@onready var launch_direction := Vector3.ZERO
@onready var target : Node
#
@export var interText : String
@onready var interLabel := $Sprite3D/SubViewport/Label
#
@onready var col : KinematicCollision3D
func _physics_process(delta):
	Custom_Gravity(delta)
	RegularMove(delta)
	Jump(delta)
	#GetCollisions()
	velocity = move_direction + gravity + jumpVector
	move_and_slide()
func RegularMove(DELTA:float):
	move_Input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	move_Input.z = Input.get_action_strength("back") - Input.get_action_strength("forward")
	move_Input = move_Input.rotated(Vector3.UP,camSystem.rotation.y).normalized()
	move_direction = move_Input.normalized() * speed * DELTA
func Jump(DELTA:float):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jumpVector += transform.basis.y * jumpForce * DELTA
		await get_tree().create_timer(0.25).timeout
		if Input.is_action_pressed("jump") and !is_on_floor():
			jumpVector -= transform.basis.y * jumpForce * DELTA
	if Input.is_action_just_released("jump") and !is_on_floor():
		jumpVector -= transform.basis.y * jumpForce * DELTA
	if is_on_floor() && jumpVector != -get_floor_normal() :
		jumpVector = -get_floor_normal() * DELTA
func GetCollisions():
	for i in get_slide_collision_count():
		col = get_slide_collision(i)
		col.get_collider()
		PushRigids()
func PushRigids():
	if col.get_collider() is RigidBody3D:
		if is_on_wall() && col.get_collider().gravity_scale>0.5:
			col.get_collider().apply_central_impulse(-col.get_normal()*(col.get_collider().mass))
func Take_Damage(dmg:=0.0):
	life = life - dmg * dmg_ctrl
	print(life)
	#if life <= 0.5:
		#Death()
func Death():
	queue_free()
func _on_sight_body_entered(body):
	pass
