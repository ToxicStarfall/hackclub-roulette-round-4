@tool
extends Path2D

@export var path: Texture2D
@export var outline: Texture2D


func _ready():
	pass


func _enter_tree() -> void:
	set_notify_transform(true)


func _notification(what):
	if Engine.is_editor_hint():
		if what == NOTIFICATION_TRANSFORM_CHANGED:
			queue_redraw()


func _draw() -> void:
	var baked_points = curve.get_baked_points()
	curve.bake_interval = 10 # edit this to have more distance between each sprite
	for point in baked_points:
		draw_texture(outline, point - Vector2(28,28))
	for point in baked_points:
		draw_texture(path, point - Vector2(24,24))
