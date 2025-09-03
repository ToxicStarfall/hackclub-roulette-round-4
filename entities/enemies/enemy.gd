class_name Enemy
extends Entity

enum EnemyTypes {
	BASIC,
}


#func _ready() -> void:
	#pass

func setup():
	super()
	add_to_group("enemies")


#@export var chase_radius: float = 300.0
#@export var detection_radius: float = 200.0
#@export var follow_radius: float = 50.0

func get_distance_to_home():
	pass
