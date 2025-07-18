class_name Meteor
extends Projectile

@export var _rotation_speed: float = 1.0

func _process(delta: float) -> void:
    rotate(_rotation_speed * delta)
