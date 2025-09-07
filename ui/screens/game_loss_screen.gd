extends Control


func _ready() -> void:
	%RestartButton.pressed.connect( _on_restart_button_pressed )
	%MenuButton.pressed.connect( _on_menu_button_pressed )


func _on_restart_button_pressed() -> void:
	Game.restart_level()
	print("ASDL")
	self.hide()


func _on_menu_button_pressed() -> void:
	Game.end_level()
	self.hide()
