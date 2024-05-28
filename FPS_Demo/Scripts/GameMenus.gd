extends Control

@onready var menuOptions := $Menu_Options

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
func _input(event):
	if Input.is_action_just_pressed("escape"):
		get_tree().paused = !get_tree().paused
		$".".visible = get_tree().paused
	if get_tree().paused == true:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
func _on_resume_button_down():
	get_tree().paused = !get_tree().paused
	$".".visible = get_tree().paused
func _on_retry_button_down():
	get_tree().paused = !get_tree().paused
	get_tree().reload_current_scene()
func _on_options_button_down():
	menuOptions.visible = !menuOptions.visible
func _on_quit_button_down():
		get_tree().quit()



