class_name FollowPath
extends State


@export var movement_speed = 50.0
var path: Path2D
var path_point_count: int = 0
var path_start_pos: Vector2
var path_end_pos: Vector2
var path_point_idx = 0
var segment_len = 0
var segment_start_pos: Vector2
var segment_end_pos: Vector2


func enter():
	follow_path()


func physics_process_state(_delta):
	entity.move_and_slide()

	#print(segment_len," - ", (entity.global_position - segment_start_pos).length())
	if segment_len <= (entity.global_position - segment_start_pos).length():
		if path_point_idx + 2 < path_point_count:
			path_point_idx += 1
			follow_path_segment()
		else:
			entity.velocity = Vector2.ZERO


func exit():
	pass


func follow_path():
	path = entity.get_parent()
	path_point_count = path.curve.point_count
	path_start_pos = path.curve.get_point_position(0)
	path_end_pos = path.curve.get_point_position(path_point_count - 1)
	path_point_idx = 0
	entity.global_position = path_start_pos
	follow_path_segment()


func follow_path_segment():
	#print(path_point_idx)
	segment_start_pos = path.curve.get_point_position(path_point_idx)
	segment_end_pos = path.curve.get_point_position(path_point_idx + 1)
	#print("start: %s, end: %s" % [segment_start_pos, segment_end_pos])
	var dir = segment_end_pos - segment_start_pos
	segment_len = dir.length()
	entity.velocity = dir.normalized() * movement_speed
