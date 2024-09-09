extends Node
@export_group("Player Spawn")
@export var player_res : PackedScene = preload("res://Scenes/Player/tps_player.tscn")
@onready var player_instance : CharacterBody3D
@export var playerSpawnMarker : Marker3D = null
@export_group("MOBs Spawn")
@export var mobs_resources : Array [PackedScene]
@onready var mob_instance : Node3D
@onready var m_r_index : int = 0
@export var time_index : float = 1.0
@export var startTimer : float
@onready var currentTime : float
@export var mobSpawnMarker : Marker3D = null
signal spawnPlayer
signal spawnMobs
func _ready():
	playerSpawnMarker.set_as_top_level(true)
	mobSpawnMarker.set_as_top_level(true)
	emit_signal("spawnPlayer")
	emit_signal("spawnMobs")
func _physics_process(delta):
	Custom_Timer(delta)
func _on_spawn_player():
	player_instance = player_res.instantiate()
	get_parent().add_child.call_deferred(player_instance)
	player_instance.position + (Vector3.UP * 2)
func _on_spawn_mobs():
	mob_instance = mobs_resources[m_r_index].instantiate()
	get_parent().add_child.call_deferred(mob_instance)
	mob_instance.player = player_instance
	mob_instance.position = mobSpawnMarker.position + (Vector3.UP * 2)
	if m_r_index >= mobs_resources.size()-1:
		m_r_index = 0
	else:m_r_index += 1
func ResetTimer():
	currentTime = startTimer
func Custom_Timer(DELTA:float):
	currentTime -= time_index * DELTA
	if currentTime == startTimer/startTimer:
		emit_signal("spawnMobs")
	if currentTime == startTimer/2:
		emit_signal("spawnMobs")
	if currentTime <= startTimer - startTimer:
		emit_signal("spawnMobs")
		ResetTimer()
#func _ready():
	#index = 0
#func _physics_process(delta):
	#CustomTimer(delta)
#func SpawnRandomAI():
	#mobNode = mobScenes[index].instantiate()
	#add_child(mobNode)
	#mobNode.target = player
	#mobNode.set_as_top_level(true)
	#if index >= mobScenes.size()-1:
		#index = 0
	#else:index += 1
#func CustomTimer(d:float):
	#currentTime -= 1 * d 
	#if currentTime == startTimer/startTimer:
		#emit_signal("spawn")
	#if currentTime == startTimer/2:
		#emit_signal("spawn")
	#if currentTime <= startTimer - startTimer:
		#emit_signal("spawn")
		#ResetTimer()
#func ResetTimer():
	#currentTime = startTimer
#func _on_spawn():
	#SpawnRandomAI()
