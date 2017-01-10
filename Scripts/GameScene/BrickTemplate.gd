
extends StaticBody2D

var top
var right
var left
var bottom

var hit = false

func _ready():
	top = SegmentShape2D.new()
	top.set_a(Vector2(0,0))
	top.set_b(Vector2(128,0))
	
	right = SegmentShape2D.new()
	right.set_a(Vector2(128,0))
	right.set_b(Vector2(128,64))
	
	bottom = SegmentShape2D.new()	
	bottom.set_a(Vector2(0,64))
	bottom.set_b(Vector2(128,64))
	
	left = SegmentShape2D.new()
	left.set_a(Vector2(0,0))
	left.set_b(Vector2(0,64))
	
	set_meta("Type", global.TYPE.BRICK)

func addCollision(side):
	if (side == global.TOP):
		add_shape(top)
		return
	
	if (side == global.RIGHT):
		add_shape(right)
		return
	
	if (side == global.BOTTOM):
		add_shape(bottom)
		return
		
	if (side == global.LEFT):
		add_shape(left) 
		return

func removeCollision():
	while (get_shape_count()):
		remove_shape(0)

#BLUE = 1,
#GREEN = 2,
#BROWN = 3,
#ORANGE = 4,
#PINK = 5,
#RED = 6,
#TEAL = 7,
#YELLOW = 8
#BLACK = 9

func setColor(iColor):
	if (iColor == global.BRICK_COLOR.BLUE):
		get_child(0).set_texture(get_parent().BLUE_BRICK)
	if (iColor == global.BRICK_COLOR.GREEN):
		get_child(0).set_texture(get_parent().GREEN_BRICK)
	if (iColor == global.BRICK_COLOR.BROWN):
		get_child(0).set_texture(get_parent().BROWN_BRICK)
	if (iColor == global.BRICK_COLOR.ORANGE):
		get_child(0).set_texture(get_parent().ORANGE_BRICK)
	if (iColor == global.BRICK_COLOR.PINK):
		get_child(0).set_texture(get_parent().PINK_BRICK)
	if (iColor == global.BRICK_COLOR.RED):
		get_child(0).set_texture(get_parent().RED_BRICK)
	if (iColor == global.BRICK_COLOR.TEAL):
		get_child(0).set_texture(get_parent().TEAL_BRICK)
	if (iColor == global.BRICK_COLOR.YELLOW):
		get_child(0).set_texture(get_parent().YELLOW_BRICK)
	if (iColor == global.BRICK_COLOR.BLACK):
		get_child(0).set_texture(get_parent().BLACK_BRICK)