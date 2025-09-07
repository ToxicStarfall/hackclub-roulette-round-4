class_name HitboxComponent
extends Area2D


signal hit(damage: Damage)


func _init() -> void:
	area_entered.connect( _on_hitbox_area_entered )
	body_entered.connect( _on_hitbox_body_entered )


func _ready() -> void:
	pass


func _on_hitbox_area_entered(area):
	#print(area, " entered hitbox")
	hit.emit(area.get_damage().duplicate(), area)

	#if area is Projectile:
	area.hit(get_parent().AttackComp.projectile_damage)
	#	area.queue_free()


func _on_hitbox_body_entered(body):
	#print(body, " entered hitbox")
	if body.faction != get_parent().faction:  # Prevent damaging self
		hit.emit(body.get_damage(), body)

		#if body is Projectile:
		#	body.queue_free()
