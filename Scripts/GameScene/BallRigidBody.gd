
extends KinematicBody2D

var ballSpeed = 800
var moveVector = Vector2(ballSpeed, -ballSpeed)
var turnSpeed = Vector2(15,15)
var launched = false
var grown = false
var faster = false
var onFire = false

func _ready():
	set_fixed_process(true)
	var dropNode = get_node("/root/Node2D/DropNode")
	dropNode.connect("Create_Extra_Ball", self, "createExtraBall")
	dropNode.connect("Increase_Ball_Size", self, "increaseBallSize")
	dropNode.connect("Increase_Speed", self, "increaseBallSpeed")
	dropNode.connect("Activate_Fireball", self, "fireball")
	
	set_meta("Type", global.TYPE.BALL)

func _fixed_process(delta):
	if (is_colliding()):
		if (!onFire):
			collide(get_collision_pos(), false)
			notifyBricks()
		else:
			var type = get_collider().get_meta("Type")
			if (type == global.TYPE.WALL || type == global.TYPE.PADDLE):
				collide(get_collision_pos(), false)
			notifyBricks()
	
	if (launched):
		moveBall(moveVector, delta)
		if (get_pos().y > get_viewport_rect().size.y + 64):
			queue_free()

func collide(collisionPos, isPaddle):
	# reference: http://www.gamasutra.com/view/feature/131424/pool_hall_lessons_fast_accurate_.php?page=2 
	
	var n = get_pos() - collisionPos
	
	# If it hits the side of the moving paddle, we must move the ball a bit further than normal to account for faster moving paddle speed
	if (isPaddle):
		if (n.x > 0):
			set_pos(Vector2(get_pos().x + 25, get_pos().y))
		elif (n.x < 0):
			set_pos(Vector2(get_pos().x - 25, get_pos().y))
	
	var radius = get_child(1).get_shape().get_radius() * get_child(1).get_scale()
	radius = radius.x
	
	# Correction for very small inaccuracies in godot's collision
	#print("n = ", n)
	var correction = 1
	if (grown):
		correction = 2
	if (n.x > -correction && n.x < correction):
		n.x = 0
		if (n.y < 0):
			n.y = -radius
		else:
			n.y = radius
	if (n.y > -correction && n.y < correction):
		n.y = 0
		if (n.x < 0):
			n.x = -radius
		else:
			n.x = radius
	# end of correction code
	
	n = n.normalized()
	var a = moveVector.dot(n)
	var P = 2.0 * a
	
	moveVector = moveVector - P * n

func notifyBricks():
	var collider = get_collider()
	if (collider.get_meta("Type") == global.TYPE.BRICK):
		collider.get_parent().updateAdjacentBricks(collider)
	elif(collider.get_meta("Type") == global.TYPE.PADDLE):
		get_parent().scoreIncrease()

func moveBall(moveVector, delta):
	# prevent horizontal movement
	if (moveVector.y < 100 && moveVector.y > -100):
		if (moveVector.y > 0):
			moveVector.y = 101
		else:
			moveVector.y = -101
		#moveVector = moveVector.normalized() * ballSpeed
	moveVector = moveVector.normalized() * ballSpeed
	self.move(moveVector * delta)


func launch():
	var mod = randi() % 2
	if (mod):
		moveVector.x = -moveVector.x
	launched = true      

func get_move_vector():
	return moveVector

func set_move_vector(v):
	moveVector = v

func createExtraBall():
	var newBall = get_parent().ballScn.instance()
	get_parent().add_child(newBall)
	newBall.set_pos(Vector2(get_pos().x + 32, get_pos().y + 32))
	newBall.set_move_vector(Vector2(-get_move_vector().x, newBall.get_move_vector().y))
	newBall.launch()

func increaseBallSize():
	if (!grown):
		set_scale(Vector2(get_scale().x + 1, get_scale().y + 1))
		grown = true

func increaseBallSpeed():
	if (ballSpeed < 2200):
		ballSpeed += 200

func fireball():
	onFire = true
	increaseBallSpeed()
