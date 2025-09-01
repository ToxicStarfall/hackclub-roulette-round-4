class_name Projectile
extends Entity


func _ready() -> void:
	super()
	#self.body_entered.connect( _on_body_entered )


func _physics_process(delta: float) -> void:
	move_and_slide()


#func _on_body_entered(body):
	#var damage = body.get_damage().projectile_damage
	#HealthComp.apply_damage(damage)


func _on_hitbox_hit(damage):
	if damageable:
		HealthComp.apply_damage(damage)
	else: print(self, " is immune.")
