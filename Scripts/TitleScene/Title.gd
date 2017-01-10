
extends Node

var gameScene = null

func _ready():
	var mouse = load("res://assets/PNG/white-arrow.png")
	Input.set_custom_mouse_cursor(mouse)

func startGameScene():
	get_node("/root/global").setScene("res://Game.tscn")

func setColor(color):
	Globals.set("BALL_COLOR", color)

func _on_Blue_pressed():
	setColor(global.COLOR.BLUE)
	startGameScene()

func _on_Cyan_pressed():
	setColor(global.COLOR.CYAN)
	startGameScene()

func _on_Green_pressed():
	setColor(global.COLOR.GREEN)
	startGameScene()

func _on_Grey_pressed():
	setColor(global.COLOR.GREY)
	startGameScene()

func _on_Orange_pressed():
	setColor(global.COLOR.ORANGE)
	startGameScene()

func _on_Pink_pressed():
	setColor(global.COLOR.PINK)
	startGameScene()

func _on_Red_pressed():
	setColor(global.COLOR.RED)
	startGameScene()

func _on_Teal_pressed():
	setColor(global.COLOR.TEAL)
	startGameScene()

func _on_Yellow_pressed():
	setColor(global.COLOR.YELLOW)
	startGameScene()