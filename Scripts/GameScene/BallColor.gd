
extends Sprite

func _ready():
	var dropNode = get_node("/root/Node2D/DropNode")
	dropNode.connect("Activate_Fireball", self, "fireball", [], CONNECT_ONESHOT)
	
	var ballNode = get_node("/root/Node2D/BallNode")
	
	var color = Globals.get("BALL_COLOR")
	
	if (color == global.COLOR.BLUE):
		set_texture(ballNode.blueBall)
	elif (color == global.COLOR.CYAN):
		set_texture(ballNode.cyanBall)
	elif (color == global.COLOR.GREEN):
		set_texture(ballNode.greenBall)
	elif (color == global.COLOR.GREY):
		set_texture(ballNode.greyBall)
	elif (color == global.COLOR.ORANGE):
		set_texture(ballNode.orangeBall)
	elif (color == global.COLOR.PINK):
		set_texture(ballNode.pinkBall)
	elif (color == global.COLOR.RED):
		set_texture(ballNode.redBall)
	elif (color == global.COLOR.TEAL):
		set_texture(ballNode.tealBall)
	elif (color == global.COLOR.YELLOW):
		set_texture(ballNode.yellowBall)

func fireball():
	set_modulate(Color(1, 0.3, 0.3, 1))
	get_material().set_shader_param("amount", 1)