extends RigidBody3D

@export var speed := 5.0
@export var jumpForce := 4.5

@export var camRef : NodePath
@onready var cam = get_node(camRef)

@onready var move_Input := Vector3.ZERO
@onready var direction := Vector3.ZERO
@onready var gravity := Vector3.ZERO
@onready var jumpVector := Vector3.ZERO

@onready var groundCheck := $GroundCheck
@onready var onGround := false
@onready var groundNormal := Vector3.ZERO

@onready var wallCheck:= $WallCheck
@onready var onWall := false
@onready var wallNormal := Vector3.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity_Direction = ProjectSettings.get_setting("physics/3d/default_gravity_vector")
func _integrate_forces(state: PhysicsDirectBodyState3D):
	LookAt()
	OnGround()
	Gravity(get_physics_process_delta_time())
	Jump(get_physics_process_delta_time())
	JumpVectorCheck(get_physics_process_delta_time())
	Move(get_physics_process_delta_time())
	linear_velocity = direction + gravity + jumpVector 
#func _physics_process(delta):
	#LookAt()
	#OnGround()
	#Gravity(delta)
	#Jump(delta)
	#JumpVectorCheck(delta)
	#Move(delta)
	#linear_velocity = direction + gravity + jumpVector
func Gravity(DELTA:float):
	if OnGround() == false:
		gravity += gravity_Direction * 100 * DELTA
	else:
		gravity = -groundCheck.get_collision_normal() * DELTA
func LookAt():
	if Input.is_action_pressed("aim"):
		rotation.y = cam.rotation.y
	else:
		if move_Input.x != 0.0 || move_Input.z != 0.0:
			look_at(position+ move_Input,Vector3.UP)
func Move(DELTA:float):
	move_Input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	move_Input.z = Input.get_action_strength("back") - Input.get_action_strength("forward")
	move_Input = move_Input.rotated(Vector3.UP,cam.rotation.y).normalized()
	direction = move_Input.normalized() * speed * DELTA
func Jump(DELTA:float):	
	if Input.is_action_just_pressed("jump") && OnGround():
		jumpVector += lerp(jumpVector, transform.basis.y * jumpForce * DELTA,10*DELTA)
		await get_tree().create_timer(0.25).timeout
		if Input.is_action_pressed("jump") && !OnGround():
			jumpVector -= transform.basis.y * jumpForce * 0.5 * DELTA
	if Input.is_action_just_released("jump") && !OnGround():
		jumpVector -= transform.basis.y * jumpForce * 0.5 * DELTA
func OnWall()->bool:
	if !wallCheck.is_colliding():
		return false
	else:
		return true
	return true
func OnGround()->bool:
	if !groundCheck.is_colliding():
		return false
	else:
		return true
	return true
func JumpVectorCheck(DELTA:float):
	if !Input.is_action_pressed("jump") && OnGround():
		jumpVector = -groundCheck.get_collision_normal()
		print("onground")
