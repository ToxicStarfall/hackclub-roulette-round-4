class_name Entity
extends CharacterBody2D
#extends Node2D

enum Factions {
	NONE, ALLIED, ENEMY
}
#enum EntityTypes {
	#BASIC,
#}

#@export_category("Atritbutes")
#@export var entity_type: EntityTypes
#@export var projectile_damage = 1 ## Damage dealt to incomming projectile on contact

@export var faction: Factions

#@export_group("Body Parts")
#@export var turrets: Array = []
#@export var legs: Array = []

@export_group("Targets")
#@export var targets_player: bool = true
#@export var entity_targets: Array[Entity]
#@export var faction_targets: Array[Entity]

@export_group("Traits")
@export var damageable: bool = true
@export var healable: bool = true
@export var killable: bool = true

var HitboxComp: HitboxComponent
var HealthComp: HealthComponent
var AttackComp: AttackComponent
#var MovementComp: MovementComponent


func _ready() -> void:
	setup()


## Initialize and checks for entity components.
func setup():
	if has_node("HitboxComponent"): HitboxComp = $HitboxComponent
	if has_node("HealthComponent"): HealthComp = $HealthComponent
	if has_node("AttackComponent"): AttackComp = $AttackComponent
	#if has_node("MovementComponent"): MovementComp = $MovementComponent

	if HitboxComp:
		HitboxComp.hit.connect( _on_hitbox_hit )
	if HealthComp:
		HealthComp.health_damaged.connect( _on_health_damaged )
		HealthComp.health_zero.connect( _on_health_zero )
	# if AttackComp:
	# 	AttackComp
	#if MovementComp:
		#MovementComp

	add_to_group("entities")


func _on_hitbox_hit(damage: Damage):
	if damageable:
		HealthComp.apply_damage(damage)
	else: print(self, " is immune.")


# damaged effects
func _on_health_damaged():
	#if has_node("SparksParticles"):
		#$"SparksParticles".emitting = true
	pass


func _on_health_zero():
	if killable:
		kill()
	else: print(self, " is immortal.")


func kill():
	print(self, " killed.")
	$Sprite2D.hide()
	$HitboxComponent.queue_free()
	#$CollisionShape2D.queue_free()
	self.velocity = Vector2.ZERO

	if self is Enemy:
		#get_parent().score += 5
		pass
	#if self is Player: get_parent().game_loss()
	else:
		#await $"SparksParticles".finished
		queue_free()


func get_health():
	if HealthComp: return HealthComp.health


func get_damage():
	if AttackComp: return AttackComp.DamageComp


# func get_faction():
# 	return faction


func get_target(target_filter):

	pass
