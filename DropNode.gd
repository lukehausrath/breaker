extends Node2D

signal Create_Extra_Ball
signal Increase_Ball_Size
signal Increase_Paddle_Size
signal Increase_Speed
signal Activate_Fireball

var SPEED = load("res://assets/PNG/drops/speed.png")
var BALL_SIZE = load("res://assets/PNG/drops/ballSize.png")
var PADDLE_SIZE = load("res://assets/PNG/drops/paddleSize.png")
var EXTRA_BALL = load("res://assets/PNG/drops/extraBall.png")
var FIREBALL = load("res://assets/PNG/drops/fireball.png")

var stopped = false

const fallSpeed = 250
const drops = {
	EXTRA_BALL = 0,
	BALL_SIZE = 1,
	PADDLE_SIZE = 2,
	SPEED = 3,
	FIREBALL = 4
}

func _ready():
	set_fixed_process(true)
	get_parent().connect("NewLevel", self, "newLevel")

func _fixed_process(delta):
	if (!stopped):
		for child in get_children():
			child.move(Vector2(0, fallSpeed * delta))
			
			# This only detects vertical collisions. Horizontal collisions are detected and handled by the paddle.
			if (child.is_colliding()):
				child.activate()

func newLevel():
	for drop in get_children():
		drop.queue_free()
	stopped = false

func stop():
	stopped = true