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

var scoreNode
var previousModifier = 1

func _ready():
	set_process(true)
	
	scoreNode = get_node("/root/Node2D/Score")
	assert(scoreNode != null)
	
	var paddle = get_node("/root/Node2D/PaddleKinematicBody")
	paddle.connect("Launched", self, "set_launched")

func _process(delta):
	var childCount = get_child_count()
	if (launched && !childCount):
		get_parent().titleScene()
	
	if (childCount != previousModifier):
		scoreNode.emit_signal("score_modifier", childCount)
		previousModifier = childCount

func set_launched():
	launched = true

func scoreIncrease():
	scoreNode.emit_signal("increase_score", 5)