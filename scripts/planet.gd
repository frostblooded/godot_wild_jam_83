class_name Planet
extends Node2D

@export var _area: Area2D
@export var _sprite: Sprite2D
@export var _sprite_rotation_speed: float = 1.0

func _enter_tree() -> void:
    _area.area_entered.connect(_on_hit)

func _ready() -> void:
    Globals.planet = self

func _process(delta: float) -> void:
    _sprite.rotate(_sprite_rotation_speed * delta)

func _on_hit(area: Area2D) -> void:
    if area.owner.is_in_group("meteorites"):
        area.owner.queue_free()
        EventBus.lost_life.emit()
    elif area.owner.is_in_group("repair_packs"):
        area.owner.queue_free()
        EventBus.gained_life.emit()
