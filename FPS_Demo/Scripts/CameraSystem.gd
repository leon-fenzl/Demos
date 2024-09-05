extends SpringArm3D
class_name CamSystem

@onready var cam := $Camera3D
@onready var camBasis := Vector3.ZERO
@export var displace_Height : float
@export var mouse_Speed : float
@export var ctrl_Speed : float
@export var offset := 0.0

@export var pitch := Vector2(-80.0,80.0)
@export var yaw := Vector2(0.0,360.0)
@export var armLength := Vector2(0.0,0.0)
@export var playerRef : NodePath
@onready var player := get_node(playerRef)

@onready var camInputs := Vector2.ZERO
@onready var new_value : float = 10
@onready var aimPoint := Vector3.ZERO

@onready var pointer := $RayCast3D/Marker3D
@onready var ray := $RayCast3D
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.x -= event.relative.y*mouse_Speed*get_physics_process_delta_time()
		rotation.x = clamp(rotation.x,deg_to_rad(pitch.x),deg_to_rad(pitch.y))
		rotation.y -= event.relative.x*mouse_Speed*get_physics_process_delta_time()
		rotation.y = wrapf(rotation.y,deg_to_rad(yaw.x),deg_to_rad(yaw.y))
func _physics_process(delta: float) -> void:
	Lock_On_Off(delta)
	ray.position = Vector3(cam.position.x + cam.h_offset,cam.position.y,cam.position.z-1)
	position = lerp(position, +Vector3(player.position.x,player.position.y+displace_Height,player.position.z),10*delta)
	Controller_Inputs()
	Ctrlr_Pitch_Yaw(delta)
func Controller_Inputs()-> void:
	camInputs = Input.get_vector("r_joy_left","r_joy_right","r_joy_up","r_joy_down").normalized()
func Ctrlr_Pitch_Yaw(DELTA:float)-> void:
	rotation.x -= camInputs.y*ctrl_Speed*DELTA
	rotation.x = clamp(rotation.x,deg_to_rad(pitch.x),deg_to_rad(pitch.y))
	rotation.y -= camInputs.x*ctrl_Speed*DELTA
	rotation.y = wrapf(rotation.y,deg_to_rad(yaw.x),deg_to_rad(yaw.y))
func Lock_On_Off(DELTA:float):
	cam.h_offset = lerpf(cam.h_offset,offset*Input.get_action_raw_strength("aim"),24.0*DELTA)
