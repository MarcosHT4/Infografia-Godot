extends Label


onready var board = get_owner()

func _ready():
	board.connect('change_turn', self, 'change_label_text')

func change_label_text(player_turn):
	if player_turn:
		text = 'Turn: Player 1'
	else:
		text = 'Turn: Player 2'	
		
