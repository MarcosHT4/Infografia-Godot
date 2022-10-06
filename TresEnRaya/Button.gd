extends Button

var current_symbol = self.text

signal on_button_pressed(button)


	
func _on_Button_button_up():
	 emit_signal("on_button_pressed", self)
