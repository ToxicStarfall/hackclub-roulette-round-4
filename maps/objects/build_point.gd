extends Area2D
class_name BuildPoint


@export var disallowed_buildings: Array[Buildings.Types] = []
#@export var cost_multiplier = 1.0


var hovered


func _ready() -> void:
	mouse_entered.connect( _on_mouse_entered )
	mouse_exited.connect( _on_mouse_exited )


func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if hovered and event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			print("ASD")
			pass

func _on_mouse_entered():
	hovered = true
func _on_mouse_exited():
	hovered = false
