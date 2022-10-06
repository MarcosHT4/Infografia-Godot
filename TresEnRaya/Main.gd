extends Node2D

var board = [[],[],[]]

var row_counter = 0
var col_counter = 0
var player_turn = true
var player_one_score = 0
var player_two_score = 0

signal change_turn(player_turn)
signal change_score(score_string)
func _ready():
	
	for i in self.get_children():
		if col_counter == 3:
			row_counter+=1
			col_counter = 0
		if i is Button:
			board[row_counter].append(i)
			col_counter+=1
		
		
	for row in board:
		for button in row:
			button.connect('on_button_pressed', self, 'on_button_pressed')
			
			

func on_button_pressed(button):
	if button.text == '':
		if player_turn:
			button.text = 'X'
		else:
			button.text = 'O'	
		if check_winner():
			if player_turn:
				print('Player 1 Won!')
				player_one_score+=1
			else:
				print('Player 2 Won!')	
				player_two_score+=1
			emit_signal("change_score", str("Player 1 Wins: " + str(player_one_score) + "\nPlayer 2 Wins: " + str(player_two_score)))	
			reset_board()
		elif tie_game():	
			reset_board()
		player_turn = not player_turn
		emit_signal("change_turn", player_turn)		
		

func tie_game():
	for row in board:
		for button in row:
			if button.text == '':
				return false
	return true					
		
func reset_board():
	for row in board:
		for button in row:
			button.text = ''
		
		
func check_winner():
	return check_rows() || check_columns() || check_diagonals()
		
		
				
func check_rows():		
	for row in board:
		if row[0].text == row[1].text && row[1].text == row[2].text && row[0].text != '':
			return true	
			
func check_columns():
	
	for col in range(0,3):
		if board[0][col].text == board[1][col].text && board[1][col].text == board[2][col].text && board[0][col].text != '':
			return true
			
func check_diagonals():
	
	if board[0][0].text == board[1][1].text && board[1][1].text  == board[2][2].text && board[0][0].text != '' or  board[0][2].text == board[1][1].text && board[1][1].text  == board[2][0].text && board[0][2].text != '':
		return true
