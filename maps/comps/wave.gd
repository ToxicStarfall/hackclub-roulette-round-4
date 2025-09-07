class_name Wave
extends Resource


#@export var spawner: int = 0
#@export var enemies: Dictionary[int, PackedScene]
@export var time: float = 0.0
@export var sequences: Array[EnemySequence] = []
