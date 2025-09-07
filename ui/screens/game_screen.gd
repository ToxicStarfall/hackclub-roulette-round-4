extends Control


signal building_selected(building: Ally)

const pixel_size = 32
var map
var maprect

@onready var building_options = preload("res://ui/building_button_group.tres")


func _ready() -> void:
	Game.level_started.connect( _on_level_started )
	Game.level_ended.connect( _on_level_ended )
	Game.level_won.connect( func():
		%GameWinScreen.show()
		Game.end_level())
	%HelpButton.pressed.connect(
		func():
			Game.paused = true
			get_parent().get_node("%HelpScreen").show() )
	pass


func _process(_delta: float) -> void:
	var mouse_pos = get_local_mouse_position()
	var x = floor(mouse_pos.x / pixel_size) * pixel_size
	var y = floor(mouse_pos.y / pixel_size) * pixel_size
	$TileSelector.position = Vector2(x, y)
	if %BuildingBar.building_hint:
		%BuildingBar.building_hint.global_position = Vector2(x,y) + Vector2(16,16)


func _on_level_started(level) -> void:
	map = Game.current_level.get_node("TileMapLayer")
	maprect = map.get_used_rect()

	%GameScreen/%LifeLabel.text = "Lives: %s" % [level.lives]
	%GameScreen/%EnergyLabel.text = "Energy: %s" % [level.energy]
	level.lives_changed.connect( _on_level_lives_changed )
	level.energy_changed.connect( _on_level_energy_changed )
	level.wave_changed.connect( _on_level_wave_changed )


func _on_level_ended(level) -> void:
	%GameScreen/%LifeLabel.text = "Lives: 0"
	%GameScreen/%EnergyLabel.text = "Energy: 0"
	%GameScreen/%WaveLabel.text = "Wave: 0"


func _on_level_lives_changed(new_lives) -> void:
	%GameScreen/%LifeLabel.text = "Lives: %s" % [new_lives]
	if new_lives <= 0:
		Game.paused = true
		%GameLossScreen.show()


func _on_level_energy_changed(new_energy) -> void:
	%GameScreen/%EnergyLabel.text = "Energy: %s" % [new_energy]


func _on_level_wave_changed(new_wave) -> void:
	%GameScreen/%WaveLabel.text = "Wave: %s" % [new_wave]
