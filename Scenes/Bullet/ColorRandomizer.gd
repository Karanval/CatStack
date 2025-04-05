extends Sprite2D


@export var colors: Array[Color]

func _ready() -> void:
	randomize()
	modulate = colors[randi_range(0, colors.size()-1)]
