class_name Player
extends CharacterBody2D

@export var _movement_speed: float = 200.0

@export var _sprite: Sprite2D

func _process(_delta: float) -> void:
    _set_sprite_rotation()

func _physics_process(_delta: float) -> void:
    if !InputManager.can_player_move:
        velocity = Vector2.ZERO
        return

    var input: Vector2 = Input.get_vector("player_left", "player_right", "player_up", "player_down")
    velocity = input * _movement_speed
    move_and_slide()

func _set_sprite_rotation() -> void:
    if velocity.length() > 0:
        _sprite.rotation = sin(Time.get_unix_time_from_system() * 10) / 2
    else:
        _sprite.rotation = 0.0
