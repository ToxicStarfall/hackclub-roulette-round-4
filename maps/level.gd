class_name Level
extends Node2D

signal lives_changed(new_lives)
signal energy_changed(new_energy)
signal wave_changed(new_wave)

#static var default_lives = 10
#static var default_energy = 25
@export var starting_lives: int = 10
@export var starting_energy: int = 25

@export var building_whitelist: Array[Buildings.Types] = []
@export var building_blacklist: Array[Buildings.Types] = []

@export var waves: Array[Wave] = []

@export var spawnpoints: Array[EntitySpawner] = []
@export var paths: Array[Path2D] = []


#var spawn_queue: Dictionary = {}
var elapsed_time: float = 0.0

var lives = starting_lives :
	set(value):
		lives = value
		lives_changed.emit(lives)
var energy = starting_energy :
	set(value):
		energy = value
		energy_changed.emit(energy)
var wave_counter = 0 : ## -1 = not started
	set(value):
		wave_counter = value
		wave_changed.emit(value)


func _ready() -> void:
	#lives_changed.connect( _on_lives_changed )
	#energy_changed.connect()
	pass


func _physics_process(delta: float) -> void:
	if !Game.paused:
		elapsed_time += delta
		for wave in waves:
			if elapsed_time >= wave.time:
				var sequence_group = wave.sequences
				for sequence in sequence_group:
					spawn_sequence(sequence)
				wave_counter += 1
				waves.erase(wave)
		if waves == []:
			if get_tree().get_nodes_in_group("enemies").size() == 0:
				Game.paused = true
				Game.level_won.emit()


func _unhandled_input(event: InputEvent) -> void:#(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		# Mouse button pressed
		if event.pressed:
			pass
		# Mouse button released
		else:
			if event.button_index == MOUSE_BUTTON_LEFT:
				var building = Buildings.get_building(Game.selected_building_type)
				if Game.selected_building_type != Buildings.Types.NULL:
					place_building(building, get_mouse_tile())
			if event.button_index == MOUSE_BUTTON_RIGHT:
				# Cancel building placement
				Game.selected_building_type = Buildings.Types.NULL


func _on_enemy_death() -> void:
	#if enemy is Enemy:
	energy += 1


func get_mouse_tile():
	var map: TileMapLayer = self.get_node("TileMapLayer")
	var maprect = map.get_used_rect()
	var pixel_size = 32
	var mouse_pos = get_local_mouse_position()
	var x = floor(mouse_pos.x / pixel_size) #* pixel_size
	var y = floor(mouse_pos.y / pixel_size) #* pixel_size
	return Vector2i(x, y)


func spawn_sequence(sequence: EnemySequence):
	for i in sequence.amount:
		var enemy = load("res://entities/enemies/%s.tscn" % [sequence.enemy]).instantiate()
		enemy.tree_exited.connect( _on_enemy_death )
		self.get_node("Path2D").add_child(enemy)
		enemy.position = self.get_node("EntitySpawner").position
		await get_tree().create_timer(sequence.interval).timeout


func place_building(building: Building, tile_coords: Vector2):
	if tile_is_buildable(tile_coords):
		if energy >= building.energy_cost:
			tile_set_buildable(tile_coords, false)
			building.placed = true
			building.queue_redraw() # Redraw to remove range circle
			%Buildings.add_child(building)
			building.global_position = tile_coords * Vector2(32,32) + Vector2(16,16)
			energy -= building.energy_cost
	else:
		pass


#func start():
	#pass

#func end():
	#pass


func tile_is_buildable(tile: Vector2i):
	#print($BuildZones.get_cell_atlas_coords(tile))
	if $BuildZones.get_cell_atlas_coords(tile) == Vector2i(0,2):
		#print("tile is not buildable")
		return false
	else:
		return true


func tile_set_buildable(tile, buildable: bool):
	if buildable:
		$BuildZones.set_cell(tile, -1)
	else:
		$BuildZones.set_cell(tile, 1, Vector2i(0, 2))
