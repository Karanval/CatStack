class_name PlayerAnimator extends AnimationTree

@export var _sprites_root : Node2D
@export var _blend_speed: float = 10
@export var _animation_player: AnimationPlayer

var to_fall: bool = false
var _running: bool = false
var _jumping: bool = false
var _hugging: bool = false

func set_movement(velocity: Vector2, on_floor: bool) -> void:
	
	if _jumping || _hugging || !on_floor:
		return
	
	if velocity.x > 0:
		_sprites_root.scale.x = 1.4
	elif velocity.x < 0:
		_sprites_root.scale.x = -1.4
	
	if velocity.x == 0.0:
		_running = false
		_animation_player.play("idle")
	else: # !_running:
		_animation_player.play("run")


func jump() -> void:
	_jumping = true
	_animation_player.play("falling")
	to_fall = true

func land() -> void:
	_jumping = false
	_animation_player.play("idle")
	to_fall = true

func hug() -> void:
	_hugging = true
	_animation_player.play("hug")
	
func stop_hug() -> void:
	_hugging = false
	_animation_player.play("idle")
