extends Label

var score = 0
var modifier = 1
signal increase_score
signal score_modifier

func _ready():
	set_process(true)
	
	connect("increase_score", self, "increaseScore")
	connect("score_modifier", self, "setScoreModifier")
	
	

func _process(delta):
	#set_text(str(OS.get_frames_per_second()))
	set_text(str(score))

func increaseScore(value):
	score += (value * modifier)

func setScoreModifier(value):
	modifier = value