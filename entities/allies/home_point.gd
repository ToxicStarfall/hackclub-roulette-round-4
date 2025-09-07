class_name HomePoint
extends Ally


## Initialize and checks for entity components.
#func setup():
	#super()

	#if HealthComp:
		#HealthComp.health_damaged.connect( _on_health_damaged )


func _on_hitbox_hit(damage, inflictor):
	Game.current_level.lives -= 1

	if inflictor is Enemy:
		# Remove enemy death energy reward if death by HomePoint
		for i in inflictor.tree_exited.get_connections():
			inflictor.tree_exited.disconnect(i.callable)
		inflictor.hit(self.get_damage())
