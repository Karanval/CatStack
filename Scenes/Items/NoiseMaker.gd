extends Sprite2D


@export var _area: Area2D
@export var _noise: Node2D
@export var _noise_timer: Timer
@export var _type: Type

enum Type{Chicken, Monke, Maraca}

var _noising: bool =false
var rotating_clockwise := true
var _noise_type: Sound.Effect

func _ready() -> void:
	_area.body_entered.connect(activate_noise)
	_noise_timer.one_shot = true
	_noise_timer.timeout.connect(deactivate_noise)
	_noise_type = Sound.Effect.Chicken if _type == Type.Chicken else \
	Sound.Effect.Monke if _type == Type.Monke else \
	Sound.Effect.Maraca
	
func _process(delta: float) -> void:
	if _noising:
		if rotating_clockwise:
			rotation += delta * 3
			if rotation > 0.17:
				rotating_clockwise = false
		else:
			rotation -= delta * 3
			if rotation < -0.17:
				rotating_clockwise = true
		
func activate_noise(_body: Node2D) -> void:
	if _noising:
		return
	_noising = true
	Sound.play_effect(_noise_type)
	_noise.show()
	_noise_timer.start()
	GameManager.changeSleep(-7)


func deactivate_noise() -> void:
	_noise.hide()
	_noising = false
	rotation = 0
	rotating_clockwise = true
