extends BaseMonster

func _ready() -> void:
	speed_modifier += randf_range(-0.05, 0.05)
