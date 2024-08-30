extends SpringArm3D
class_name CamSystem

@onready var cam := $Camera3D
@onready var camBasis := Vector3.ZERO
@export var displace_Height : float
@export var mouse_Speed : float
@export var ctrl_Speed : float

@export var pitch := Vector2(-80.0,80.0)
@export var yaw := Vector2(0.0,360.0)
@export var armLength := Vector2(0.0,0.0)
@export var playerRef : NodePath
@onready var player := get_node(playerRef)

@onready var camInputs := Vector2.ZERO
@onready var new_value : float = 10
@onready var aimPoint := Vector3.ZERO
#@onready var ray := $Camera3D/RayCast3D
@onready var ray := $RayCast3D
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.x -= event.relative.y*mouse_Speed*get_physics_process_delta_time()
		rotation.x = clamp(rotation.x,deg_to_rad(pitch.x),deg_to_rad(pitch.y))
		rotation.y -= event.relative.x*mouse_Speed*get_physics_process_delta_time()
		rotation.y = wrapf(rotation.y,deg_to_rad(yaw.x),deg_to_rad(yaw.y))
#Zoom-in Zoom-out do spring de acordo com o pitch da Câmera
		#if event.relative.y > 0.5 || event.relative.y < -0.5:
			#new_value += 0.5 * event.relative.y * get_physics_process_delta_time()
		#new_value = clamp(new_value,armLength.x,armLength.y)
		#$".".set_length(new_value)
func _physics_process(delta: float) -> void:
	ray.position = Vector3(cam.position.x+ cam.h_offset,cam.position.y,cam.position.z-1)
	cam.transform.basis.z += transform.basis.z
	camBasis = cam.transform.basis.z
	position = lerp(position, +Vector3(player.position.x,player.position.y+displace_Height,player.position.z),10*delta)
	Controller_Inputs()
	Ctrlr_Pitch_Yaw(delta)
func Controller_Inputs()-> void:
	camInputs = Input.get_vector("r_joy_left","r_joy_right","r_joy_up","r_joy_down").normalized()
#Zoom-in Zoom-out do spring de acordo com o pitch da Câmera
	#if camInputs.y > 0.5 || camInputs.y < -0.5:
		#new_value += 1 * camInputs.y * get_physics_process_delta_time()
	#new_value = clamp(new_value,armLength.x,armLength.y)
func Ctrlr_Pitch_Yaw(DELTA:float)-> void:
	rotation.x -= camInputs.y*ctrl_Speed*DELTA
	rotation.x = clamp(rotation.x,deg_to_rad(pitch.x),deg_to_rad(pitch.y))
	rotation.y -= camInputs.x*ctrl_Speed*DELTA
	rotation.y = wrapf(rotation.y,deg_to_rad(yaw.x),deg_to_rad(yaw.y))
