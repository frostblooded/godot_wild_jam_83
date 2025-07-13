class_name Player
extends Node2D

@export var _area: Area2D

func _enter_tree() -> void:
    _area.area_entered.connect(_on_hit)

func _on_hit(area: Area2D) -> void:
    if area.owner.is_in_group("meteorites"):
        print("Player hit by meteorite!")
        area.owner.queue_free()
        EventBus.increased_score.emit()
