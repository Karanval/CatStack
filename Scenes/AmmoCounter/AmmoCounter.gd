extends Control

var ammo_scene = preload("res://Scenes/AmmoCounter/Ammo.tscn")
	
func _ready() -> void:
	GameManager.ammo_changed.connect(update_ammo_count)
	update_ammo_count(GameManager.getAmmo())
	
func update_ammo_count(count: int):
	remove_all_ammo()
	for a in range(count):
		add_one_ammo()
	
func remove_all_ammo():
	var ammos = $MarginContainer/HBoxContainer.get_children()
	for a in ammos:
		$MarginContainer/HBoxContainer.remove_child(a)
		
func add_one_ammo():
	var ammo = ammo_scene.instantiate()
	$MarginContainer/HBoxContainer.add_child(ammo)
