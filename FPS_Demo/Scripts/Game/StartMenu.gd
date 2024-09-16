extends Control
class_name Start_Menu
@onready var baseMenu := $"."
@onready var btt_resume := $Start
@onready var btt_Retry := $Continue
@onready var btt_Options := $Options
@onready var btt_Quit := $Quit
func _on_start_button_down():
	get_tree().change_scene_to_file("res://Scenes/Levels/Game_Hub.tscn")
	
