class_name Projectile
#extends Entity
extends Area2D

@export var velocity: Vector2
@export var damageable: bool = true
var faction: Entity.Factions
var HealthComp: HealthComponent

func _ready() -> void:
	#super()
	#self.body_entered.connect( _on_body_entered )
	_setup()
	$VisibleOnScreenNotifier2D.screen_exited.connect( func(): queue_free() )

func _setup() -> void:
	if has_node("HealthComponent"): HealthComp = $HealthComponent
	#if HealthComp:
		#HealthComp.health_damaged.connect( _on_health_damaged )
		#HealthComp.health_zero.connect( _on_health_zero )


func _physics_process(delta: float) -> void:
	#move_and_slide()
	self.position += velocity * delta


#func _on_body_entered(body):
	#var damage = body.get_damage().projectile_damage
	#HealthComp.apply_damage(damage)


func _on_hitbox_hit(damage):
	if damageable:
		#HealthComp.apply_damage(damage)
		queue_free()
	else: print(self, " is immune.")


func get_damage():
	if has_node("AttackComponent"): return get_node("AttackComponent").DamageComp
