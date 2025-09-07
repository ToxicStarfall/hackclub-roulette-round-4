extends HBoxContainer



@onready var BuildingsButtonGroup: ButtonGroup = preload("res://ui/building_button_group.tres")
var building_button: BuildingButton
var building_hint: Building


func _ready() -> void:
	Game.level_started.connect( _on_level_started )
	Game.level_ended.connect( _on_level_ended )

	for child in get_children():
		if child is Button:
			child.button_group = BuildingsButtonGroup
			child.toggle_mode = true
			child.toggled.connect( _on_building_button_toggled )
	#BuildingsButtonGroup.pressed.connect( _on_building_button_selected )


#func _on_building_button_selected(button):
	#Game.selected_building_type = button.get_index()
	#print(button.get_index(), " - ", button)


func _on_building_button_toggled(toggled_on):
	building_button = BuildingsButtonGroup.get_pressed_button()
	if toggled_on:
		Game.selected_building_type = building_button.building_type
		building_hint = Buildings.get_building(building_button.building_type)
		building_hint.hint_mode(true)
		Game.current_level.add_child(building_hint)
		set_building_info(building_hint)
		get_parent().get_parent().get_node("%BuildingInfoContainer").show()
	else:
		Game.current_level.remove_child(building_hint)
		building_hint = null

		Game.selected_building_type = Buildings.Types.NULL
		get_parent().get_parent().get_node("%BuildingInfoContainer").hide()


func _on_level_started(_level):
	# Add/Remove Building options
	pass

func _on_level_ended(_level):
	#for child in self.get_children():
		#remove_child( child )
	pass


func set_building_info(building: Building):
	%BuildingInfo.text = \
"[b]%s[/b]
%s energy" % [building_button.tooltip_text, building.energy_cost]
	pass
