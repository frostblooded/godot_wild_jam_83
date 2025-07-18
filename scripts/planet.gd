class_name Planet
extends Node2D

@export var _area: Area2D
@export var _sprite: Sprite2D
@export var _sprite_rotation_speed: float = 1.0
@export var _guide_sprite: Sprite2D

func _enter_tree() -> void:
    _area.area_entered.connect(_on_hit)
    EventBus.changed_orbiting_radius.connect(_on_orbiting_radius_changed)

func _ready() -> void:
    Globals.planet = self

func _process(delta: float) -> void:
    _sprite.rotate(_sprite_rotation_speed * delta)

func _on_hit(area: Area2D) -> void:
    if area.owner.is_in_group("meteorites"):
        EventBus.lost_life.emit()
    elif area.owner.is_in_group("repair_packs"):
        EventBus.gained_life.emit()

    area.owner.queue_free()

func _on_orbiting_radius_changed(new_radius: float) -> void:
    _guide_sprite.scale.x = new_radius / 100
    _guide_sprite.scale.y = new_radius / 100
