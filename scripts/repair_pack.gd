class_name RepairPack
extends Projectile

@export var _rotation_speed: float = 1.0
@export var _rotation_amplitude_mult: float = 0.2

func _process(_delta: float) -> void:
    rotation = sin(Time.get_unix_time_from_system() * _rotation_speed) * _rotation_amplitude_mult
