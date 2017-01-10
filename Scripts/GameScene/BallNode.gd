extends Node2D

var launched = false
var ballScn = preload("res://Ball.tscn")
var blueBall = preload("res://assets/PNG/marbles/Blue.png")
var cyanBall = preload("res://assets/PNG/marbles/Cyan.png")
var greenBall = preload("res://assets/PNG/marbles/Green.png")
var greyBall = preload("res://assets/PNG/marbles/Grey.png")
var orangeBall = preload("res://assets/PNG/marbles/Orange.png")
var pinkBall = preload("res://assets/PNG/marbles/Pink.png")
var redBall = preload("res://assets/PNG/marbles/Red.png")
var tealBall = preload("res://assets/PNG/marbles/Teal.png")
var yellowBall = preload("res://assets/PNG/marbles/Yellow.png")

func _ready():
	set_process(true)
	
	var paddle = get_node("/root/Node2D/PaddleKinematicBody")
	paddle.connect("Launched", self, "set_launched")

func _process(delta):
	if (launched && !get_child_count()):
		get_parent().titleScene()

func set_launched():
	launched = true