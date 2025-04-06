extends Control

var ammo_scene = preload("res://Scenes/AmmoCounter/Ammo.tscn")
var _current_ammo: int
	
func _ready() -> void:
	GameManager.ammo_changed.connect(update_ammo_count)
	_current_ammo = 0
	update_ammo_count(GameManager.getAmmo())
	
func update_ammo_count(count: int):
	var diff = count - _current_ammo
	for a in range(abs(diff)):
		if diff < 0:
			remove_one_ammo()
		if diff > 0:
			add_one_ammo()

func remove_one_ammo():
	var ammos = $HBoxContainer.get_children()
	if ammos.size() > 0:
		$HBoxContainer.remove_child(ammos[0])
		_current_ammo -= 1
		
func add_one_ammo():
	var ammo = ammo_scene.instantiate()
	$HBoxContainer.add_child(ammo)
	_current_ammo += 1
