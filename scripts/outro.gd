class_name Outro
extends Node

@export var main_scene: PackedScene

    get_tree().change_scene_to_packed(main_scene)
