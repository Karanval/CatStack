extends Sprite2D

func _ready() -> void:
	var tween = create_tween()
	tween.tween_method(set_shader_value, Color("#f3e1f500"), Color("#f3e1f5c8"), GameManager.GAME_LENGTH).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_EXPO)


# tween value automatically gets passed into this function
func set_shader_value(value: Color):
	# in my case i'm tweening a shader on a texture rect, but you can use anything with a material on it
	material.set_shader_parameter("color", value);
