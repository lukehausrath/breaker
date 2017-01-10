extends KinematicBody2D


var dropIndex = 0
var const_drops = {}
var activated = false
const fallSpeed = 250

func _ready():
	set_fixed_process(true)
	
	const_drops = get_parent().drops
	dropIndex = randi() % const_drops.size()
	var sprite = get_child(0)
	
	set_meta("Type", global.TYPE.DROP)
	
	if (dropIndex == const_drops.FIREBALL):
		sprite.set_texture(get_parent().FIREBALL)
	if (dropIndex == const_drops.EXTRA_BALL):
		sprite.set_texture(get_parent().EXTRA_BALL)
	if (dropIndex == const_drops.BALL_SIZE):
		sprite.set_texture(get_parent().BALL_SIZE)
	if (dropIndex == const_drops.PADDLE_SIZE):
		sprite.set_texture(get_parent().PADDLE_SIZE)
	if (dropIndex == const_drops.SPEED):
		sprite.set_texture(get_parent().SPEED)


func _fixed_process(delta):
	if (activated || get_pos().y > get_viewport_rect().size.y + 100):
		queue_free()


func activate():
	if (!activated):
		activated = true
		if (dropIndex == const_drops.EXTRA_BALL):
			get_parent().emit_signal("Create_Extra_Ball")
		if (dropIndex == const_drops.BALL_SIZE):
			get_parent().emit_signal("Increase_Ball_Size")
		if (dropIndex == const_drops.PADDLE_SIZE):
			get_parent().emit_signal("Increase_Paddle_Size")
		if (dropIndex == const_drops.SPEED):
			get_parent().emit_signal("Increase_Speed")
		if (dropIndex == const_drops.FIREBALL):
			get_parent().emit_signal("Activate_Fireball")