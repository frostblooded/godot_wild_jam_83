class_name RadiusDownPowerup
extends Powerup

@export var _duration: float = 5.0
@export var _radius_multiplier: float = 0.5

var _timer: SceneTreeTimer

func apply(player: Player) -> void:
    if _timer:
        _timer.timeout.disconnect(_on_timer_timeout)

    _timer = player.get_tree().create_timer(_duration)
    _timer.timeout.connect(_on_timer_timeout)

    player.set_orbiting_radius(player.get_initial_orbiting_radius() * _radius_multiplier)

func _on_timer_timeout() -> void:
    Globals.player.set_orbiting_radius(Globals.player.get_initial_orbiting_radius())
