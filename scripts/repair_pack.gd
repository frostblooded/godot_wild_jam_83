class_name RepairPack
extends Node2D

@export var _speed: float = 100.0
@export var _rotation_speed: float = 1.0
@export var _rotation_amplitude_mult: float = 0.2

func _process(_delta: float) -> void:
    rotation = sin(Time.get_unix_time_from_system() * _rotation_speed) * _rotation_amplitude_mult

func _physics_process(delta: float) -> void:
    if !Globals.planet:
        return

    var direction: Vector2 = Globals.planet.global_position - global_position
    global_position += direction.normalized() * _speed * delta
