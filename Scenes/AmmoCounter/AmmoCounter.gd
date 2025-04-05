extends CenterContainer
	
func _ready() -> void:
	GameManager.ammo_changed.connect(update_ammo_count)
	
func update_ammo_count(count: int):
	$AmmoText.text = "Ammo: " + str(count)
