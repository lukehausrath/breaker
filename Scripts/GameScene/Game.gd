
extends Node

var currentLevel = 1

signal NewLevel

func _ready():	
	set_process(true)
	randomize()
	Input.set_custom_mouse_cursor(load("res://assets/PNG/transparentMouse.png"))
	
	get_node("NextLevelTimer").connect("timeout", self, "timeout")
	
	get_node("LevelText").set_text(str("Level ", currentLevel))
	get_node("LevelText/LevelSubText").set_text("Press space to launch ball")

func _process(delta):
	if(Input.is_key_pressed(KEY_ESCAPE)):
		titleScene()
	if(Input.is_key_pressed(KEY_SPACE)):
		hideText()
	if(Input.is_key_pressed(KEY_0)):
		nextLevel()

func titleScene():
	get_node("/root/global").setScene("res://Title.tscn")

func hideText():
	get_node("LevelText").hide()
	get_node("LevelText/LevelSubText").hide()

func nextLevel():
	currentLevel += 1
	#called from bricks
	get_node("LevelText").set_text("Level Complete!")
	get_node("LevelText").show()
	get_node("NextLevelTimer").start()
	get_node("BallNode").stop()

func timeout():
	get_node("LevelText").set_text(str("Level ", currentLevel))
	get_node("LevelText/LevelSubText").show()
	emit_signal("NewLevel")