class_name Player
extends Node2D

@export var orbiting_radius: float = 100.0
@export var default_orbiting_speed: float = 1.0
@export var increased_orbiting_mult: float = 2.0
@export var _area: Area2D
@export var _sprite: Sprite2D
@export var _sprite_rotation_speed: float = 1.0

var _angle: float = 0.0

func _enter_tree() -> void:
    _area.area_entered.connect(_on_hit)

func _ready() -> void:
    position = Vector2(0, orbiting_radius)

func _physics_process(delta: float) -> void:
    var used_rotation_speed: float = default_orbiting_speed

    if Input.is_action_pressed("speed_up_player"):
        used_rotation_speed *= increased_orbiting_mult

    _angle += used_rotation_speed * delta
    position = Globals.get_position_on_circle(Vector2.ZERO, orbiting_radius, _angle)

func _process(delta: float) -> void:
    _sprite.rotate(_sprite_rotation_speed * delta)

func _on_hit(area: Area2D) -> void:
    if area.owner.is_in_group("meteorites"):
        area.owner.queue_free()
        EventBus.increased_score.emit()
