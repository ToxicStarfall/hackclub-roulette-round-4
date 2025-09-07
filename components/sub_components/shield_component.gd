extends Node
class_name ShieldComponent

# Should be child of HealthComp as a intermediator for damage application


@export var max_shield: int = 1
var shield: float = max_shield

#@export var shield_regen: float = 1
#@export var shield_regen_time: float = 1