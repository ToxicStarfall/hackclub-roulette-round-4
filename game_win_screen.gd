extends Control

func _ready() -> void:
	$CenterContainer/VBoxContainer/Button.pressed.connect( func(): self.hide() )
