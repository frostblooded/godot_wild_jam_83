class_name Planet
extends Node

@export var _player: Node
@export var _initial_player_radius: float = 100.0
@export var _default_rotation_speed: float = 1.0
@export var _increased_rotation_speed: float = 2.0

var _player_angle: float = 0.0

func _ready() -> void:
    _player.position = Vector2(0, _initial_player_radius)
    Globals.planet = self

func _physics_process(delta: float) -> void:
    _set_player_position(delta)

func _set_player_position(delta: float) -> void:
    var used_rotation_speed: float = _default_rotation_speed

    if Input.is_action_pressed("speed_up_player"):
        used_rotation_speed = _increased_rotation_speed

    _player_angle += used_rotation_speed * delta
    _player.position = Globals.get_position_on_circle(Vector2.ZERO, _initial_player_radius, _player_angle)
