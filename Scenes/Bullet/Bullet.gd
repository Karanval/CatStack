extends Node2D

@export var DAMAGE: int
@export var DIRECTION: Vector2
@export var START_POSITION: Vector2
@export var SPEED: int
@export var CAN_HIT_OBJECTS: bool

signal damage_inflicted

var _velocity

func _ready() -> void:
	self.position = START_POSITION
	_velocity = DIRECTION.normalized() * SPEED
	
func _physics_process(delta: float) -> void:
	self.position += _velocity * delta

# Bullet hits a monster
func _on_area_2d_body_entered(body: Node2D) -> void:
	var monster := body as BaseMonster
	monster.take_damage(DAMAGE)
	emit_signal("damage_inflicted", body, DAMAGE)
	call_deferred("queue_free")
