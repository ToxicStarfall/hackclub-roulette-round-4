class_name RangeComponent
extends Area2D


var enemies = []
@export var a = 0


func _ready() -> void:
	body_entered.connect( _on_body_entered )
	body_exited.connect( _on_body_exited )
	#if


func _on_body_entered(body) -> void:
	if body is Enemy:
		enemies.append(body)


func _on_body_exited(body) -> void:
	if body is Enemy:
		enemies.erase(body)
