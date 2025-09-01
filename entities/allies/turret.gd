extends Ally
class_name Turret


var a = 0.5
var b = 0.0


func setup():
	super()


func _physics_process(delta: float) -> void:
	b += delta
	if b >= a:
		b = 0.0
		var target = get_tree().get_first_node_in_group("enemies")
		var attack_dir = (target.global_position + target.velocity) - self.global_position
		#attack_dir += Vector2(attack_dir.normalized()*100)

		var projectile = $ProjectileSpawner.spawn()
		projectile.velocity = attack_dir.normalized() * 120.0
		projectile.position = $ProjectileSpawner.global_position
		projectile.faction = self.faction # self.user.faction
		#projectile.add_child( $AttackComponent.duplicate() )
		get_parent().get_parent().add_child(projectile)

		$RayCast2D.target_position = attack_dir
		pass


func _process(delta: float) -> void:
	pass
