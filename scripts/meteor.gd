class_name Meteor
extends Node2D

@export var _speed: float = 100.0
@export var _rotation_speed: float = 1.0

func _process(delta: float) -> void:
    rotate(_rotation_speed * delta)

func _physics_process(delta: float) -> void:
    var direction: Vector2 = Globals.planet.global_position - global_position
    global_position += direction.normalized() * _speed * delta
