class_name Spawner
extends Node2D

@export var _spawned_scene: PackedScene
@export var _spawn_radius: float = 100.0
@export var _spawn_interval_min: float = 1.5
@export var _spawn_interval_max: float = 3.0
@export var _timer: Timer

func _enter_tree() -> void:
    _timer.timeout.connect(_spawn)

func _ready() -> void:
    _start_spawn_timer()

func _spawn() -> void:
    var instance: Node2D = _spawned_scene.instantiate()
    var spawned_position: Vector2 = Globals.get_position_on_circle(global_position, _spawn_radius, randf() * 2 * PI)
    instance.global_position = spawned_position
    get_tree().root.add_child(instance)

    _start_spawn_timer()

func _start_spawn_timer() -> void:
    _timer.wait_time = randf_range(_spawn_interval_min, _spawn_interval_max)
    _timer.start()
