class_name Ui
extends Node

@export var _reverse_key_fake_image: Control
@export var _reverse_cooldown_progress_bar: ProgressBar

var _reverse_cooldown_timer: Timer = null

func _enter_tree() -> void:
    EventBus.reverse_cooldown_timer_started.connect(_on_reverse_cooldown_started)

func _ready() -> void:
    _reverse_key_fake_image.show()
    _reverse_cooldown_progress_bar.hide()

func _process(_delta: float) -> void:
    if _reverse_cooldown_timer == null:
        return

    if _reverse_cooldown_timer.is_stopped():
        _on_reverse_cooldown_ended()
        return

    var timer_progress: float = (_reverse_cooldown_timer.wait_time - _reverse_cooldown_timer.time_left) / _reverse_cooldown_timer.wait_time
    _reverse_cooldown_progress_bar.value = timer_progress * 100

func _on_reverse_cooldown_started(cooldown_timer: Timer) -> void:
    _reverse_key_fake_image.hide()
    _reverse_cooldown_progress_bar.show()
    _reverse_cooldown_timer = cooldown_timer

func _on_reverse_cooldown_ended() -> void:
    _reverse_key_fake_image.show()
    _reverse_cooldown_progress_bar.hide()
    _reverse_cooldown_timer = null
