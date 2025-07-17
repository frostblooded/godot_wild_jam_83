class_name Player
extends Node2D

@export var orbiting_radius: float = 100.0
@export var default_orbiting_speed: float = 1.0
@export var increased_orbiting_mult: float = 2.0
@export var _area: Area2D
@export var _sprite: Sprite2D
@export var _sprite_rotation_speed: float = 1.0
@export var _last_meteor_hit_guide_scene: PackedScene
@export var _initial_orbiting_clockwise: bool = true
@export var _reverse_cooldown_timer: Timer

var _angle: float = 0.0
var _angle_since_last_meteor_hit: float = 0.0
var _last_meteor_hit_guide: Node2D
var _orbiting_clockwise: bool = true

func _enter_tree() -> void:
    _area.area_entered.connect(_on_hit)

func _ready() -> void:
    position = Vector2(0, orbiting_radius)
    _orbiting_clockwise = _initial_orbiting_clockwise

func _physics_process(delta: float) -> void:
    var gained_angle: float = _get_gained_angle(delta)
    _angle += gained_angle
    _update_last_meteor_hit_guide(gained_angle)

    position = Globals.get_position_on_circle(Vector2.ZERO, orbiting_radius, _angle)

func _process(delta: float) -> void:
    if Input.is_action_just_pressed("reverse_player"):
        if _reverse_cooldown_timer.is_stopped():
            _orbiting_clockwise = !_orbiting_clockwise
            _reverse_cooldown_timer.start()
            EventBus.reverse_cooldown_timer_started.emit(_reverse_cooldown_timer)

    _sprite.rotate(_sprite_rotation_speed * delta)

func _on_hit(area: Area2D) -> void:
    if area.owner.is_in_group("meteorites"):
        area.owner.queue_free()
        EventBus.increased_score.emit(_get_meteor_score_increase())
        _on_meteor_hit_update_last_meteor_hit_guide()
        _angle_since_last_meteor_hit = 0.0
    elif area.owner.is_in_group("repair_packs"):
        area.owner.queue_free()
    
func _update_last_meteor_hit_guide(gained_angle: float) -> void:
    if _last_meteor_hit_guide == null:
        return

    _angle_since_last_meteor_hit += gained_angle

    if _angle_since_last_meteor_hit > PI * 2:
        _last_meteor_hit_guide.queue_free()

func _on_meteor_hit_update_last_meteor_hit_guide() -> void:
    if _last_meteor_hit_guide == null:
        _last_meteor_hit_guide = _last_meteor_hit_guide_scene.instantiate() as Node2D
        get_tree().root.add_child(_last_meteor_hit_guide)

    _last_meteor_hit_guide.global_position = global_position

func _get_meteor_score_increase() -> int:
    if _angle_since_last_meteor_hit <= PI * 2:
        return 2

    return 1

func _get_gained_angle(delta: float) -> float:
    var used_rotation_speed: float = default_orbiting_speed

    if Input.is_action_pressed("speed_up_player"):
        used_rotation_speed *= increased_orbiting_mult

    var gained_angle: float = used_rotation_speed * delta

    if !_orbiting_clockwise:
        gained_angle *= -1

    return gained_angle
