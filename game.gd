#class_name Game
extends Node

signal level_started(level: Level)
signal level_ended(level: Level)
signal level_won

var levels = []

var paused = true

var current_level: Level
var level_idx: int = NAN

var selected_building_type: Buildings.Types


@onready var Main = get_tree().root.get_node("Main")
@onready var UI = Main.get_node("UI")


func _ready() -> void:
	for level in ResourceLoader.list_directory("res://maps/levels"):
		var level_scene = "res://maps/levels/%s" % [level]
		levels.append(load(level_scene))


func start_level(level_scene, idx):
	var level = level_scene.instantiate()
	Main.add_child(level)
	current_level = level
	level_idx = idx
	Game.paused = false
	level_started.emit( level )


func end_level():
	Game.paused = true
	Main.remove_child(current_level)
	current_level.queue_free()
	level_ended.emit(null)


func restart_level():
	end_level()
	start_level(levels[level_idx], level_idx)
