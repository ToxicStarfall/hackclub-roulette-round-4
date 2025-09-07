extends MarginContainer


func _ready() -> void:
	%CloseButton.pressed.connect( _on_close_button_pressed )


func _on_close_button_pressed():
	Game.paused = false
	self.hide()
