extends Node2D

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("upgrade_menu"):
		visible = not visible

func _on_button_pressed() -> void:
	visible = false
