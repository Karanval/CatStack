extends RigidBody2D

@export var DAMAGE: int
@export var DIRECTION: Vector2
@export var START_POSITION: Vector2
@export var SPEED: int
@export var LIFETIME_SECONDS := 5

var _velocity

func _ready() -> void:
	position = START_POSITION
	_velocity = DIRECTION.normalized() * SPEED
	apply_impulse(_velocity)
	#linear_velocity = _velocity
	contact_monitor = true
	max_contacts_reported = 1
	$DestroyTimer.start(LIFETIME_SECONDS)
	
# Bullet hits a monster
func _on_body_entered(body: Node) -> void:
	var monster := body as BaseMonster
	if not monster:
		return
	set_collision_mask_value(3, false)
	monster.take_damage(DAMAGE)

func _on_destroy_timer_timeout() -> void:
	call_deferred("queue_free")
