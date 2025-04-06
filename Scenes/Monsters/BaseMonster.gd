extends RigidBody2D

class_name BaseMonster

const SPEED := -200 # go left
const HEALTH := 100
const DISTANCE_SQRD_TO_TARGET_GOAL := 100000

enum MonsterState {
	MOVING,
	DISTURBING,
	DYING
}

@export var target := Vector2(174, 734)
@export var damage := 10
@export var health := HEALTH
@export var speed_modifier := 1.0
@export var damage_scale_modifier := 0.8

var damage_tween: Tween
var state := MonsterState.MOVING
@onready var original_scale : Vector2 = $Sprite2D.scale
@onready var original_modulate : Color = $Sprite2D.modulate

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 1
	
func take_damage(damage: int):
	health -= damage
	if damage_tween:
		damage_tween.kill()
		$Sprite2D.modulate = original_modulate
		$Sprite2D.scale = original_scale
	
	if health <= 0:
		set_collision_layer_value(3, false)
		state = MonsterState.DYING
		call_deferred("die")
	else:
		damage_tween = create_tween()
		$Sprite2D.modulate = Color.PURPLE
		$Sprite2D.scale = original_scale * damage_scale_modifier
		damage_tween.tween_property($Sprite2D, "modulate", original_modulate, 0.2)
		damage_tween.parallel().tween_property($Sprite2D, "scale", original_scale, 0.2).set_trans(Tween.TRANS_BOUNCE)

func cause_disturbance():
	state = MonsterState.DISTURBING
	freeze = true
	set_collision_layer_value(3, false)
	
	if damage_tween:
		damage_tween.kill()
	damage_tween = create_tween()
	damage_tween.tween_property($Sprite2D, "modulate", Color.DARK_RED, 0.3)
	damage_tween.tween_property($Sprite2D, "modulate", Color.TRANSPARENT, 0.6)
	damage_tween.parallel().tween_property($Sprite2D, "scale", Vector2.ZERO, 0.5).set_ease(Tween.EASE_IN)
	damage_tween.parallel().tween_property($Sprite2D, "rotation", 600, 0.5).set_ease(Tween.EASE_IN)
	damage_tween.parallel().tween_property(self, "global_position", target, 0.6)
	damage_tween.tween_callback(queue_free)

func die():
	freeze = true
	contact_monitor = false
	damage_tween = create_tween()
	damage_tween.tween_property($Sprite2D, "modulate", Color.TRANSPARENT, 0.4).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	damage_tween.tween_callback(queue_free)
		
func _physics_process(delta: float) -> void:
	if state == MonsterState.MOVING:
		move_and_collide(get_velocity(delta))

func get_velocity(delta: float):
	return Vector2(SPEED * speed_modifier * delta, 0)
