class_name RangedWeapon
extends Weapon


@export var projectile_velocity: float = 300.0


func _ready() -> void:
	super()
	#user = get_parent()
	#pass


func attack():
	var attack_dir = get_global_mouse_position() - self.global_position
	var projectile = $ProjectileSpawner.spawn()
	projectile.velocity = attack_dir.normalized() * projectile_velocity
	projectile.position = $ProjectileSpawner.global_position
	projectile.faction = self.user.faction
	projectile.add_child( $AttackComponent.duplicate() )
	get_parent().get_parent().add_child(projectile)
	pass


func alt_attack():
	pass
