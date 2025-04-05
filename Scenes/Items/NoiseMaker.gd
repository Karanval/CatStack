extends Sprite2D


@export var _area: Area2D
@export var _noise: Node2D
@export var _noise_timer: Timer


var _noising: bool =false

func _ready() -> void:
	_area.body_entered.connect(activate_noise)
	_noise_timer.one_shot = true
	_noise_timer.timeout.connect(deactivate_noise)
	

func activate_noise(_body: Node2D) -> void:
	if _noising:
		return
	_noising = true
	_noise.show()
	_noise_timer.start()
	GameManager.changeSleep(-7)


func deactivate_noise() -> void:
	_noise.hide()
	_noising = false
