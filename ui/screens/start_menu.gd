extends Control


@onready var level_buttons := ButtonGroup.new()


func _ready() -> void:
	%PlayButton.pressed.connect( _on_play_button_pressed )
	for i in %LevelSelector.get_children():
		i.button_group = level_buttons
		i.toggle_mode = true
		#i.pressed.connect( _on_level_buttons_pressed )
	level_buttons.pressed.connect( _on_level_buttons_pressed )
	#print(level_buttons.pressed.get_connections())


func _on_play_button_pressed():
	%LevelSelector.show()


func _on_level_buttons_pressed(button):
	var level_idx = button.get_index()
	Game.start_level( Game.levels[level_idx], level_idx )
	self.hide()
