extends Node

@onready var parent := $".."
enum ANIM_STATES {WALK,JUMP,PUSHDRAG,SUCK,LAUNCH}
@onready var anima := ANIM_STATES.WALK
func _physics_process(delta):
	pass
