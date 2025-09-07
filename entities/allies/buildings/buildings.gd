class_name Buildings
extends Script

enum Types {
	NULL,
	CARROT,
}

const Scenes := {
	NULL = "res://entities/allies/buildings/null_building.tscn",
	CARROT = "res://entities/allies/buildings/carrot_turret.tscn",
	GARLIC = "",
}


static func get_building(type: Buildings.Types):
	if Types.find_key(type):
		var building_key = Buildings.Types.keys()[type]
		var building = load(Buildings.Scenes[building_key]).instantiate()
		return building
	else:
		var building = load(Buildings.Scenes.NULL).instantiate()
		return building
