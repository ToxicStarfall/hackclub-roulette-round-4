class_name Turret
extends Building


var cooldown_time = 0.5
var cooldown_timer = 0.0

@export var bullet_velocity = 120.


func setup():
	super()


func _draw() -> void:
	if !placed:
		var pos = (floor(get_local_mouse_position()/32) * Vector2(32,32)) + Vector2(16,16)
		draw_circle(pos, $TargetingComponent/CollisionShape2D.shape.radius, Color.WHITE, false, 2)


func _process(delta: float) -> void:
	if !placed:
		queue_redraw()


func _physics_process(delta: float) -> void:
	if placed:
		cooldown_timer += delta
		if cooldown_timer >= cooldown_time:
			cooldown_timer = 0.0
			var enemy_target = get_new_target()
			if enemy_target: attack(enemy_target)


func attack(target):
	#var target = get_tree().get_first_node_in_group("enemies")
	var target_vector: Vector2 = (target.global_position + target.velocity)

	var raw_attack_vector: Vector2 = target_vector - self.global_position
	var raw_attack_dir = raw_attack_vector.normalized()

	#var speed_ratio = target.velocity.length() / bullet_velocity
	var bullet_ratio = raw_attack_vector.length() / bullet_velocity
	#var attack_dist
	var attack_vector = (target.global_position + (target.velocity * bullet_ratio)) - self.global_position
	var attack_dir = attack_vector.normalized()
	#print(bullet_ratio, " - ")

	if has_node("ProjectileSpawner"):
		$Line2D.points[1] = raw_attack_vector
		$Line2D2.points[1] = attack_vector

		var projectile = $ProjectileSpawner.spawn()
		projectile.velocity = attack_dir * bullet_velocity
		projectile.position = $ProjectileSpawner.global_position
		#projectile.look_at(projectile.velocity)
		projectile.faction = self.faction # self.user.faction
		projectile.add_child( $AttackComponent.duplicate() )
		get_parent().get_parent().add_child(projectile)
	else:
		push_error("Missing projectile spawner in turret %s" % [self.get_script()])
