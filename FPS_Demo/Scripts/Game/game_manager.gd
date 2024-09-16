extends Node
class_name GameManager
@export_group("Spawn Settings")
@export var startTimer : float
@export_subgroup("Player Spawn")
@export var player_res : PackedScene = preload("res://Scenes/Player/tps_player.tscn")
#@export var player_hud : PackedScene = preload("res://Scenes/Player/Player_HUD.tscn")
@export var player_hud : Control
@onready var player_instance : CharacterBody3D
@export var playerSpawnMarker : Marker3D = null
signal spawnPlayer
@export_subgroup("MOBs Spawn")
@export var mobs_resources : Array [PackedScene]
@onready var mob_instance : Node3D
@onready var m_r_index : int = 0
@export var time_index : float = 1.0
@onready var currentTime : float
@export var mobSpawnMarker : Marker3D = null
signal spawnMobs
func _on_spawn_player():
	player_instance = player_res.instantiate()
	get_parent().add_child.call_deferred(player_instance)
	player_instance.position = playerSpawnMarker.position + (Vector3.UP * 2)
func _on_spawn_mobs():
	mob_instance = mobs_resources[m_r_index].instantiate()
	get_parent().add_child.call_deferred(mob_instance)
	mob_instance.player = player_instance
	mob_instance.position = mobSpawnMarker.position + (Vector3.UP * 2)
	if m_r_index >= mobs_resources.size()-1:
		m_r_index = 0
	else:m_r_index += 1
func Game_Start():
	emit_signal("spawnPlayer")
	emit_signal("spawnMobs")
	Spawn_Hud()
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
func Spawn_Player():
	emit_signal("spawnPlayer")
func Spawn_MOBs():
	emit_signal("spawnMobs")
func Spawn_Hud():
	if player_hud == null:
		player_hud = get_tree().get_first_node_in_group("hud")
		print(player_hud)
