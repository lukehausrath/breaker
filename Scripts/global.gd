extends Node

var currentScene = null
const COLOR = {
	BLUE = 1,
	CYAN = 2,
	GREEN = 3,
	GREY = 4,
	ORANGE = 5,
	PINK = 6,
	RED = 7,
	TEAL = 8,
	YELLOW = 9
}

const BRICK_COLOR = {
	BLUE = 1,
	GREEN = 2,
	BROWN = 3,
	ORANGE = 4,
	PINK = 5,
	RED = 6,
	TEAL = 7,
	YELLOW = 8,
	BLACK = 9
}

const TYPE = {
	DROP = 0,
	BALL = 1,
	PADDLE = 2,
	BRICK = 3,
	WALL = 4
}

const TOP = 0
const RIGHT = 1
const BOTTOM = 2
const LEFT = 3

func _ready():
	currentScene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() - 1)
	Globals.set("BALL_COLOR", 0)

func setScene(scene):
	currentScene.queue_free()
	var s = load(scene)
	currentScene = s.instance()
	get_tree().get_root().add_child(currentScene)
	#get_node("/root/global").setScene("res://Game.tscn")
