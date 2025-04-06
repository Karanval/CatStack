extends Node2D

var shaking := false
var rotating_clockwise := true

func _ready() -> void:
	GameManager.player_out_of_ammo.connect(_start_shaking)
	
func _process(delta: float):
	if shaking:
		if rotating_clockwise:
			rotation += delta * 3
			if rotation > 0.17:
				rotating_clockwise = false
		else:
			rotation -= delta * 3
			if rotation < -0.17:
				rotating_clockwise = true
				
func _start_shaking():
	shaking = true
	
func _stop_shaking():
	shaking = false
	rotation = 0
	rotating_clockwise = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	GameManager.setAmmo(15)
	_stop_shaking()
