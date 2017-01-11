extends Node2D

#BLUE = 1,
#GREEN = 2,
#BROWN = 3,
#ORANGE = 4,
#PINK = 5,
#RED = 6,
#TEAL = 7,
#YELLOW = 8
#BLACK = 9

var BLUE_BRICK = load("res://assets/PNG/bricks/BlueBrick.png")
var GREEN_BRICK = load("res://assets/PNG/bricks/GreenBrick.png")
var BROWN_BRICK = load("res://assets/PNG/bricks/BrownBrick.png")
var ORANGE_BRICK = load("res://assets/PNG/bricks/OrangeBrick.png")
var PINK_BRICK = load("res://assets/PNG/bricks/PinkBrick.png")
var RED_BRICK = load("res://assets/PNG/bricks/RedBrick.png")
var TEAL_BRICK = load("res://assets/PNG/bricks/TealBrick.png")
var YELLOW_BRICK = load("res://assets/PNG/bricks/YellowBrick.png")
var BLACK_BRICK = load("res://assets/PNG/bricks/BlackBrick.png")

var scoreNode

var aCurrentLevel = []
var iCurrentLevel = 0
var levelArray = []
var brickArray = []
const brickArraySize = 30
var brickCount = 0

func _ready():
	#set_process(true)
	var file = File.new()
	file.open("res://Scripts/Levels.json", file.READ)
	var allLevels = Dictionary()
	allLevels.parse_json(file.get_as_text())
	levelArray = allLevels.values()
	
	get_parent().connect("NewLevel", self, "newLevel")
	
	scoreNode = get_node("/root/Node2D/Score")
	assert(scoreNode != null)
	
	loadNextLevel()

func loadNextLevel():
	aCurrentLevel = []
	brickArray = []
	brickCount = 0
	
	var brickScene = load("res://TemplateBrick.tscn")
	
	aCurrentLevel = levelArray[iCurrentLevel]
	iCurrentLevel += 1
	for x in range(brickArraySize):
		brickArray.append([])
		for y in range(brickArraySize):
			var s = brickScene.instance()
			var brickPoints = Vector2(y * 128, x * 64)
			brickArray[x].append(s)
			s.set_pos(brickPoints)
			add_child(s)
			if (aCurrentLevel[x][y]):
				s.setColor(aCurrentLevel[x][y])
				s.show()
				brickCount += 1
	addCollision()

func updateAdjacentBricks(brick):
	scoreNode.emit_signal("increase_score", 20)
	
	var brickPos = brick.get_pos()
	var size = brick.get_child(0).get_texture().get_size()
	checkForDrop(Vector2(brickPos.x + size.x, brickPos.y + size.y))
	
	
	var column = brickPos.x / 128
	var row = brickPos.y / 64
	
	if (row):
		if (brickArray[row - 1][column] != null):
			if (!brickArray[row - 1][column].is_hidden()):
				brickArray[row - 1][column].addCollision(global.BOTTOM)
	if (column):
		if (brickArray[row][column - 1] != null):
			if (!brickArray[row][column - 1].is_hidden()):
				brickArray[row][column - 1].addCollision(global.RIGHT)
	if (row != brickArraySize - 1):
		if (brickArray[row + 1][column] != null):
			if (!brickArray[row + 1][column].is_hidden()):
				brickArray[row + 1][column].addCollision(global.TOP)
	if (column != brickArraySize - 1):
		if (brickArray[row][column + 1] != null):
			if (!brickArray[row][column + 1].is_hidden()):
				brickArray[row][column + 1].addCollision(global.LEFT)
	if (brickArray[row][column] != null):
		brick.removeCollision()
		brick.hide()
		brickCount -= 1
	brickArray[row][column] = null
	
	checkLevelCompletion()

func checkLevelCompletion():
	if (brickCount <= 0):
		get_parent().nextLevel()

func addCollision():
	for row in range(brickArraySize):
		for column in range(brickArraySize):
			var brick = brickArray[row][column]
			if (!brick.is_hidden()):
				if (row):
					if (aCurrentLevel[row - 1][column] == 0):
						brick.addCollision(global.TOP)
				if (column):
					if (aCurrentLevel[row][column - 1] == 0):
						brick.addCollision(global.LEFT)
				if (row < brickArraySize - 1):
					if (aCurrentLevel[row + 1][column] == 0):
						brick.addCollision(global.BOTTOM)
				if (column < brickArraySize - 1):
					if (aCurrentLevel[row][column + 1] == 0):
						brick.addCollision(global.RIGHT)

func checkForDrop(pos):
	var r = randi() % 5
	if (r == 1):
		drop(pos)

func drop(pos):
	var dropScene = load("res://Drop.tscn")
	var s = dropScene.instance()
	s.set_pos(pos)
	get_parent().get_node("DropNode").add_child(s)

func newLevel():
	for brick in get_children():
		brick.removeCollision()
		brick.hide()
	loadNextLevel()