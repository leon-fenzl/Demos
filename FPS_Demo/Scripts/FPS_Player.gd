extends CharacterBody3D
@export var speed := 5.0
@export var jumpForce := 4.5

@export var camRef : NodePath
@onready var cam = get_node(camRef)

@onready var move_Input := Vector3.ZERO
@onready var direction := Vector3.ZERO
@onready var upDownVector := Vector3.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity_Direction = ProjectSettings.get_setting("physics/3d/default_gravity_vector")
var col : KinematicCollision3D

func _physics_process(delta):
	Gravity(delta)
	LookAt()
	Move(delta)
	Jump(delta)
	GetCollisions()
	PushRigids()
	PushCharacters()
	velocity = direction + upDownVector
	move_and_slide()
func Gravity(DELTA:float):
	if !is_on_floor():
		upDownVector += gravity_Direction *100* DELTA
	else:
		upDownVector = -get_floor_normal() * DELTA
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
	if Input.is_action_just_pressed("jump") and is_on_floor():
		upDownVector += transform.basis.y * jumpForce * DELTA
		await get_tree().create_timer(0.25).timeout
		if Input.is_action_pressed("jump") and !is_on_floor():
			upDownVector -= transform.basis.y * jumpForce * DELTA
	if Input.is_action_just_released("jump") and !is_on_floor():
		upDownVector -= transform.basis.y * jumpForce * DELTA
func GetCollisions():
	for i in get_slide_collision_count():
		col = get_slide_collision(i)
		col.get_collider()
func PushRigids():
	if col != null:
		if col.get_collider() is RigidBody3D:
			col.get_collider().apply_central_impulse(-col.get_normal()*(col.get_collider().mass))
		#if is_on_wall() && col.get_collider().gravity_scale>0.5:
			#col.get_collider().apply_central_impulse(-col.get_normal()*(col.get_collider().mass))
func PushCharacters():
	if col != null:
		if col.get_collider() is CharacterBody3D:
			col.get_collider().velocity = velocity
			print(col.get_collider().velocity)
