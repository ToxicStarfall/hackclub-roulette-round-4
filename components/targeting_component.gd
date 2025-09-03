class_name TargetingComponent
extends Area2D #extends Node

enum Filter {
	NEAREST, FARTHEST,
	CLOSEST_TO_HOME, NEAREST_TO_HOME,
	HEALTHIEST,
	STRONGEST,
	FASTEST,
	# State filter
}

#@export var targets_player: bool = true
#@export var entity_targets: Array[Entity]
#@export var faction_targets: Array[Entity.Factions]
@export var faction_target: Entity.Factions
@export var filters: Array[Filter] = []  ## A list of filters which determine targeting priority.[br]  0 = Highest Priority.
var enemies_in_range = []
#@export var a = 0


func _ready() -> void:
	body_entered.connect( _on_body_entered )
	body_exited.connect( _on_body_exited )
	#self.collision_mask = faction_target


func _on_body_entered(body) -> void:
	if body is Enemy:
		enemies_in_range.append(body)


func _on_body_exited(body) -> void:
	if body is Enemy:
		enemies_in_range.erase(body)


func get_target():
	for enemy in enemies_in_range:
		for filter in filters:
			pass
		pass
	if enemies_in_range:
		return enemies_in_range[0]
