extends Node

var planet: Planet
var player: Player

func get_position_on_circle(center: Vector2, radius: float, angle: float) -> Vector2:
    return center + Vector2(cos(angle), sin(angle)) * radius
