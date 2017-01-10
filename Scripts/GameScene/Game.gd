
extends Node

func _ready():	
	set_process(true)
	randomize()
	Input.set_custom_mouse_cursor(load("res://assets/PNG/transparentMouse.png"))

func _process(delta):
	if(Input.is_key_pressed(KEY_ESCAPE)):
		titleScene()

func titleScene():
	get_node("/root/global").setScene("res://Title.tscn")