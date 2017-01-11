
extends KinematicBody2D
var scoreNode

var ballScn = preload("res://Ball.tscn")
var childBall = null
var rigidBall = null
var paddleWidth = 500
const paddleHeight = 50
var paddleSpeed = Vector2(2000,0)
var lastMousePos = Vector2(0,0)
const paddleY = 2160 - paddleHeight

signal Launched

var wider = false

func _ready():	
	set_process(true)
	set_fixed_process(true)
	set_process_input(true)
	self.set_pos(Vector2(get_pos().x, paddleY))
	
	var dropNode = get_node("/root/Node2D/DropNode")
	dropNode.connect("Increase_Paddle_Size", self, "increasePaddleSize")
	get_parent().connect("NewLevel", self, "newLevel")
	
	get_node("Paddle").edit_set_rect(Rect2(0,0,paddleWidth,paddleHeight))
	get_node("PaddleCollisionShape").get_shape().set_extents(Vector2(paddleWidth / 2, paddleHeight / 2))
	get_node("PaddleCollisionShape").set_pos(Vector2(paddleWidth / 2, paddleHeight / 2))
	
	assert (ballScn != null)
	childBall = ballScn.instance()
	add_child(childBall)
	
	childBall.set_pos(Vector2(paddleWidth / 2, -40))
	
	set_meta("Type", global.TYPE.PADDLE)
	
	scoreNode = get_node("/root/Node2D/Score")
	assert(scoreNode != null)

func _fixed_process(delta):
	movePaddle(delta)
	
	if (Input.is_key_pressed(KEY_SPACE)):
		launchBall()

func collide():
	var collider = get_collider()
	if (collider.get_meta("Type") == global.TYPE.DROP):
		scoreNode.emit_signal("increase_score", 15)
		collider.activate()
	if (collider.get_meta("Type") == global.TYPE.BALL):
		scoreNode.emit_signal("increase_score", 5)
		collider.collide(get_collision_pos(), true)

func movePaddle(delta):
	# Move paddle and check for horizonal collision. Horizontal collision is relevant for grarbbing drops via left/right movement,
	# since is_colliding() does not return true when the drops hit the paddle from the side. We rely on paddle to spot these collisions.
	if (Input.is_key_pressed(KEY_D) || Input.is_key_pressed(KEY_RIGHT)):
		move(paddleSpeed * delta)
		if (is_colliding()):
			collide()
	elif (Input.is_key_pressed(KEY_A) || Input.is_key_pressed(KEY_LEFT)):
		move(-paddleSpeed * delta)
		if (is_colliding()):
			collide()
	if (paddleY != get_pos().y):
		set_pos(Vector2(get_pos().x, paddleY))

func launchBall():
	emit_signal("Launched")
	if (childBall != null):
			var ballPos = childBall.get_global_pos()
			childBall.queue_free()
			childBall = null
			rigidBall = ballScn.instance()
			rigidBall.set_pos(ballPos)
			get_node("/root/Node2D/BallNode").add_child(rigidBall)
			rigidBall.launch()

func getPaddleWidth():
	return paddleWidth

func increasePaddleSize():
	if (paddleWidth <= 1000):
		paddleWidth += 100
		set_scale(get_scale() * 1.1)

func newLevel():
	set_scale(Vector2(1,1))
	
	childBall = ballScn.instance()
	add_child(childBall)
	childBall.set_pos(Vector2(paddleWidth / 2, -40))