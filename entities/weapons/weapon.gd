class_name Weapon
extends Node2D


#@export var attack_cooldown

var user: Entity


func _ready() -> void:
	user = get_parent()


func use():
	attack()


func alt_use():
	alt_attack()


func attack():
	pass


func alt_attack():
	pass


func get_damage():
	return
