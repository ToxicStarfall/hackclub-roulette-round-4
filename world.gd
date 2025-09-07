extends Node2D
#
#signal level_started
#signal level_ended
#
#@export var current_level: Level
#@export var current_tile_map: Level
#var spawn_queue: Dictionary = {}
#var elapsed_time: float = 0.0
#
#
#func _ready() -> void:
	#for wave in current_level.waves:
		#spawn_queue.set(wave.time, wave.sequences)
	##print(spawn_queue)
#
#
#func _physics_process(delta: float) -> void:
	#elapsed_time += delta
	#for i in spawn_queue:
		#if elapsed_time >= i:
			#var sequence_group = spawn_queue[i]
			#for sequence in sequence_group:
				#spawn_sequence(sequence)
			#spawn_queue.erase(i)
#
#
#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		## Mouse button pressed
		#if event.pressed:
			#if event.button_index == MOUSE_BUTTON_RIGHT:
				#print("mouse right pressed")
		## Mouse button released
		#else:
			#if event.button_index == MOUSE_BUTTON_LEFT:
				#print("mouse left released")
				#get_mouse_tile()
#
#
#func get_mouse_tile():
	#var map: TileMapLayer = current_level.get_node("TileMapLayer")
	#var maprect = map.get_used_rect()
	#var pixel_size = 32
	#var mouse_pos = get_local_mouse_position()
	#var x = floor(mouse_pos.x / pixel_size) #* pixel_size
	#var y = floor(mouse_pos.y / pixel_size) #* pixel_size
	##map.set_cell(Vector2(x, y), -1)
	#var building = Buildings.get_building(Buildings.Types.BASIC)
	#building.global_position = mouse_pos
	#$Level/%Buildings.add_child(building)
#
#
#func spawn_sequence(sequence: EnemySequence):
	#for i in sequence.amount:
		#var enemy = load("res://entities/enemies/%s.tscn" % [sequence.enemy]).instantiate()
		#current_level.get_node("Path2D").add_child(enemy)
		#enemy.position = current_level.get_node("EntitySpawner").position
		#await get_tree().create_timer(sequence.interval).timeout
	#pass
#
#
#func _on_level_started():
	#current_level
	#pass
