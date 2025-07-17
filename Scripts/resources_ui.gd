extends Node2D

@onready var virtue_label = $VirtuePoints
var virtue = Global.virtue_points

func _process(_delta: float) -> void:
	virtue_label.text = "Virtue Points: " + str(virtue)
