class_name Intro
extends Node

@export var _animation_player: AnimationPlayer
@export var _next_scene: PackedScene

func _ready() -> void:
    _animation_player.play("intro_animation")

func change_to_next_scene() -> void:
    if !_animation_player.is_playing():
        get_tree().change_scene_to_packed(_next_scene)
