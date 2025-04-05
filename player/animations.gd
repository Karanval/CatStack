class_name PlayerAnimator extends AnimationTree

@export var _sprites_root : Node2D
@export var _blend_speed: float = 10

var to_fall: bool = false
var _running: bool = false
var _jumping: bool = false

func set_movement(velocity: Vector2, on_floor: bool) -> void:
	
	if !on_floor || _jumping:
		return
	
	if velocity.x > 0:
		_sprites_root.scale.x = 1
	elif velocity.x < 0:
		_sprites_root.scale.x = -1
		
	if velocity.x == 0.0:
		_running = false
		set("parameters/conditions/jump",false)
		set("parameters/conditions/on_floor",false)
		set("parameters/conditions/run",false)
		set("parameters/conditions/to_idle",true)
	elif !_running:
		_running = true
		set("parameters/conditions/jump",false)
		set("parameters/conditions/on_floor",false)
		set("parameters/conditions/to_idle",false)
		set("parameters/conditions/run",true)


func jump() -> void:
	_jumping = true
	set("parameters/conditions/on_floor",false)
	set("parameters/conditions/run",false)
	set("parameters/conditions/to_idle",false)
	set("parameters/conditions/jump",true)
	to_fall = true

func land() -> void:
	_jumping = false
	set("parameters/conditions/on_floor",true)
	set("parameters/conditions/run",false)
	set("parameters/conditions/to_idle",false)
	set("parameters/conditions/jump",false)
	to_fall = true


func _physics_process(delta: float) -> void:
	if to_fall:
		var now = get("parameters/BlendTree/Jump/blend_amount") 
		if now == 1:
			to_fall = false
			return
		
		var lerp_val = lerp(now, 1, _blend_speed * delta)
		set("parameters/BlendTree/Jump/blend_amount", lerp_val)
