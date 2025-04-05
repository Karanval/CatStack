extends RigidBody2D

class_name BaseMonster

const SPEED := -200 # go left
const HEALTH := 100
const DISTANCE_SQRD_TO_TARGET_GOAL := 100000

enum MonsterState {
	MOVING,
	DISTURBING
}

@export var target := Vector2(174, 734)
@export var damage := 10
@export var health := HEALTH
@export var speed_modifier := 1

#var tween: Tween
var state := MonsterState.MOVING

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 1
	#var modulate_color = modulate
	#tween = create_tween()
	#tween.pause()
	#tween.tween_property($Sprite, "modulate", Color.RED, 0.2)
	#tween.tween_property($Sprite, "modulate", modulate_color, 0.2)
	
func take_damage(damage: int):
	health -= damage
	#tween.play()
	if health <= 0:
		#var tween = get_tree().create_tween()
		#tween.tween_property($Sprite, "modulate", Color.RED, 1).set_trans(Tween.TRANS_SINE)
		#tween.tween_property($Sprite, "scale", Vector2(), 1).set_trans(Tween.TRANS_BOUNCE)
		#tween.tween_callback($Sprite.queue_free)
		call_deferred("queue_free")

func _physics_process(delta: float) -> void:
	if state == MonsterState.MOVING:
		move_and_collide(get_velocity(delta))

func get_velocity(delta: float):
	return Vector2(SPEED * speed_modifier * delta, 0)
