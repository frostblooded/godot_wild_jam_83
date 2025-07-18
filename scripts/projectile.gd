class_name Projectile
extends Node2D

@export var _speed: float = 50.0

func _physics_process(delta: float) -> void:
    var direction: Vector2 = Globals.planet.global_position - global_position
    global_position += direction.normalized() * _speed * delta
