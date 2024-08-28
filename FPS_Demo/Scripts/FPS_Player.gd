extends General_Physics_Body
class_name Player

enum STATES {GROUND, COMBAT, PUSHDRAG, HOLD}
@onready var state :=STATES.GROUND
@export var camRef : NodePath
@onready var camsys = get_node(camRef)
@export var speed := 5.0
@export var jumpForce := 4.5
@onready var move_Input := Vector3.ZERO
@onready var move_direction := Vector3.ZERO
@onready var jumpVector := Vector3.ZERO

@onready var holdPosition := Vector3.ZERO
@onready var launch_direction := Vector3.ZERO
@export var interText : String
@onready var abilities := $PlayerAbilities
@onready var interLabel := $Sprite3D/SubViewport/Label
@onready var col : KinematicCollision3D
@onready var target : Node
func _physics_process(delta):
	Custom_Gravity(delta)
	LookAtDirection()
	RegularMove(delta)
	Jump(delta)
	Suckt_Launch(delta)
	#GetCollisions()
	velocity = move_direction + gravity + jumpVector
	move_and_slide()
func RegularMove(DELTA:float):
	move_Input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	move_Input.z = Input.get_action_strength("back") - Input.get_action_strength("forward")
	move_Input = move_Input.rotated(Vector3.UP,camsys.rotation.y).normalized()
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
		rotation.y = camsys.rotation.y
	else:
		if move_Input.x != 0.0 || move_Input.z != 0.0:
			look_at(position + move_Input,Vector3.UP)
func Suckt_Launch(DELTA:float):
	holdPosition = $Marker3D.global_position
	if Input.is_action_pressed("aim"):
		if target != null:
			target.holdPosition = holdPosition
			target.bullet_direction = camsys.position + -camsys.transform.basis.z * 25.0
			if target.moveState != target.MOVE_TYPES.SUCKED:
				target.moveState = target.MOVE_TYPES.SUCKED
	if Input.is_action_just_released("aim") and target != null:
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
func _on_sucktion_body_entered(body):
	if body.is_in_group("mobs") and target == null:
		target = body
func _on_sucktion_body_exited(body):
	if body.is_in_group("mobs") and !Input.is_action_pressed("aim"):
		target = null
