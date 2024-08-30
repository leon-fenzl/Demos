extends General_Physics_Body
class_name Player

enum STATES {GROUND, COMBAT, PUSHDRAG, HOLD}
@onready var state :=STATES.GROUND
@export var camRef : NodePath
@onready var camSystem = get_node(camRef)

@onready var col : KinematicCollision3D

@export var speed := 5.0
@export var jumpForce := 4.5
@onready var move_Input := Vector3.ZERO
@onready var move_direction := Vector3.ZERO
@onready var jumpVector := Vector3.ZERO

@onready var abilities := $PlayerAbilities
@onready var holdPosition := Vector3.ZERO
@onready var raycast := $RayCast3D
@onready var launch_direction := Vector3.ZERO
@onready var target : Node

@export var interText : String
@onready var interLabel := $Sprite3D/SubViewport/Label

func _physics_process(delta):
	Custom_Gravity(delta)
	LookAtDirection()
	RegularMove(delta)
	Jump(delta)
	TargetttingSystem()
	HoldPosition()
	Suck_Launch(delta)
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
func LookAtDirection():
	if Input.is_action_pressed("aim"):
		rotation.y = camSystem.rotation.y
	else:
		if move_Input.x != 0.0 || move_Input.z != 0.0:
			look_at(position + move_Input, Vector3.UP)
func TargetttingSystem():
	raycast
	launch_direction = (-camSystem.cam.transform.basis.z*100)
func HoldPosition():
	holdPosition = global_position + Vector3(0.0,2.0,0.0)
func Suck_Launch(DELTA:float):
	if Input.is_action_just_pressed("aim") and raycast.is_colliding() and target == null:
			target = raycast.get_collider()
			target.set_collision_mask_value(2,false)
	if Input.is_action_pressed("aim"):
		if target != null:
			target.holdPosition = holdPosition
			if target.moveState != target.MOVE_TYPES.SUCKED:
				target.moveState = target.MOVE_TYPES.SUCKED
	if Input.is_action_just_released("aim") and target != null:
		target.bullet_direction = camSystem.global_position + -camSystem.transform.basis.z
		target.playerVelocity = velocity
		target.moveState = target.MOVE_TYPES.BULLET
		target = null
func GetCollisions():
	for i in get_slide_collision_count():
		col = get_slide_collision(i)
		col.get_collider()
		PushRigids()
func PushRigids():
	if col.get_collider() is RigidBody3D:
		if is_on_wall() && col.get_collider().gravity_scale>0.5:
			col.get_collider().apply_central_impulse(-col.get_normal()*(col.get_collider().mass))
