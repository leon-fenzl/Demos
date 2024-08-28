extends SpringArm3D
class_name CamSystem

@export var displace_Height : float
@export var mouse_Speed : float
@export var ctrl_Speed : float

@export var pitch := Vector2(-80.0,80.0)
@export var yaw := Vector2(0.0,360.0)

@export var playerRef : NodePath
@onready var player := get_node(playerRef)

@onready var camInputs := Vector2.ZERO
@onready var new_value : float = 10
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.x -= event.relative.y*mouse_Speed*get_physics_process_delta_time()
		rotation.x = clamp(rotation.x,deg_to_rad(pitch.x),deg_to_rad(pitch.y))
		rotation.y -= event.relative.x*mouse_Speed*get_physics_process_delta_time()
		rotation.y = wrapf(rotation.y,deg_to_rad(yaw.x),deg_to_rad(yaw.y))
func _physics_process(delta: float) -> void:
	position = lerp(position, +Vector3(player.position.x,player.position.y+displace_Height,player.position.z),10*delta)
	Controller_Inputs()
	Ctrlr_Pitch_Yaw(delta)
	Zoom()
func Controller_Inputs()-> void:
	camInputs = Input.get_vector("camLeft","camRight","camUp","camDown").normalized()
func Ctrlr_Pitch_Yaw(DELTA:float)-> void:
	rotation.x -= camInputs.y*ctrl_Speed*DELTA
	rotation.x = clamp(rotation.x,deg_to_rad(pitch.x),deg_to_rad(pitch.y))
	rotation.y -= camInputs.x*ctrl_Speed*DELTA
	rotation.y = wrapf(rotation.y,deg_to_rad(yaw.x),deg_to_rad(yaw.y))
func Zoom():
	if Input.is_action_just_pressed("zoom_out"):
		new_value += 1
	if Input.is_action_just_pressed("zoom_in"):
		new_value -= 1
	new_value = clamp(new_value,2,15)
	$".".set_length(new_value)
