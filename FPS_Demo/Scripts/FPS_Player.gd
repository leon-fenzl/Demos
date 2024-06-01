extends General_Physics_Body
@export var speed := 5.0
@export var jumpForce := 4.5

@export var camRef : NodePath
@onready var cam = get_node(camRef)

@onready var move_Input := Vector3.ZERO
@onready var direction := Vector3.ZERO

@onready var jumpVector := Vector3.ZERO

func _physics_process(delta):
	Custom_Gravity(delta)
	LookAt()
	Move(delta)
	Jump(delta)
	velocity = direction + gravity + jumpVector
	move_and_slide()
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
		jumpVector += transform.basis.y * jumpForce * DELTA
		await get_tree().create_timer(0.25).timeout
		if Input.is_action_pressed("jump") and !is_on_floor():
			jumpVector -= transform.basis.y * jumpForce * DELTA
	if Input.is_action_just_released("jump") and !is_on_floor():
		jumpVector -= transform.basis.y * jumpForce * DELTA
	if is_on_floor():
		jumpVector = Vector3.ZERO
