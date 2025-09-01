class_name TargetingComponent
extends Node

enum Filter {
	NEAREST, FARTHEST,
	HEALTHY,
	STRONGEST,
	# State filter
}

#@export var targets_player: bool = true
#@export var entity_targets: Array[Entity]
#@export var faction_targets: Array[Entity]
