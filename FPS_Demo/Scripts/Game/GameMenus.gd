extends Control
enum MENU_TYPES{PAUSED,RESTART}
@onready var menu = MENU_TYPES.PAUSED
@onready var baseMenu := $Base_Menu
@onready var btt_resume := $Base_Menu/Resume
@onready var btt_Retry := $Base_Menu/Retry
@onready var btt_Options := $Base_Menu/Options
@onready var btt_Quit := $Base_Menu/Quit
@onready var btt_Back := $BttsOptions/Back
@onready var menuOptions := $BttsOptions
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
func _input(event):
	if Input.is_action_just_pressed("escape"):
		get_tree().paused = !get_tree().paused
		baseMenu.visible = get_tree().paused
	if get_tree().paused == true:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
func _on_resume_button_down():
	get_tree().paused = !get_tree().paused
	baseMenu.visible = get_tree().paused
func _on_retry_button_down():
	get_tree().paused = !get_tree().paused
	get_tree().reload_current_scene()
func _on_options_button_down():
	menuOptions.visible = !menuOptions.visible
func _on_quit_button_down():
	get_tree().quit()
func Menu_Restart():
	get_tree().paused = !get_tree().paused
	baseMenu.visible = get_tree().paused
	btt_resume.visible = !get_tree().paused
	btt_Retry.visible = get_tree().paused
	btt_Options.visible = get_tree().paused
	btt_Quit.visible = get_tree().paused
