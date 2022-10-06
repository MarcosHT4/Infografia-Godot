extends Label


onready var board = get_owner()

func _ready():
	board.connect('change_score', self, 'change_score_text')
	
func change_score_text(score_text):
	text = 	score_text
	
