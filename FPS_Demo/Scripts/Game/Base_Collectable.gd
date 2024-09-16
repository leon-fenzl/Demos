extends Area3D
class_name Base_Collectable
@export var targetMesh : Mesh
@export var rot_speed : float = 0.0
@export var value : int
@onready var collected := false
@onready var meshInst := $MeshInstance3D
func _ready():
	Set_Mesh()
func _physics_process(delta):
	meshInst.rotation.y += rot_speed * delta
	#Rotate_Self(delta)
func Set_Mesh():
	meshInst.mesh = targetMesh
func Rotate_Self(DELTA:float):
	meshInst.rotation.y += rot_speed * DELTA
	#meshInst.rotation.y = wrapf(rotation.y,0.0,360.0)
func Destroy():
	queue_free()
func _on_body_entered(body):
	PlayerHUD.Register_Coins(value)
	collected = true
	Destroy()
