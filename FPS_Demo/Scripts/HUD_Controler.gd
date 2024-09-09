extends Control

@onready var bar := $ProgressBar

func Register_Life(life:float):
	bar.value = life
