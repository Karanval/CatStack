extends TextureRect

func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color("#ffffff"), GameManager.GAME_LENGTH).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_EXPO)
