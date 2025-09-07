class_name Building
extends Ally


#var cooldown_time = 0.5
#var cooldown_timer = 0.0

@export var energy_cost: int = 10

var placed = false


func setup():
	super()


func _process(delta: float) -> void:
	#if placed:
		#pass
		#self.modulate.a = 1
	#else:
		#self.modulate.a = 0.5
		#self.global_position = get_global_mouse_position()
		#print(get_global_mouse_position())
	pass


func _physics_process(delta: float) -> void:
	pass


func hint_mode(active: bool):
	if active:
		self.modulate.a = 0.5
	else:
		pass
