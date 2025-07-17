class_name GameManager
extends Node

@export var _score_label: Label
@export var _lives_label: Label

@export var _initial_lives: int = 3

var _current_score: int = 0
var _current_lives: int = 3

func _ready() -> void:
    _current_lives = _initial_lives

func _enter_tree() -> void:
    EventBus.lost_life.connect(_on_lost_life)
    EventBus.gained_life.connect(_on_gained_life)
    EventBus.increased_score.connect(_on_increased_score)

func _on_lost_life() -> void:
    _current_lives -= 1

    if _current_lives > 0:
        _lives_label.text = "Lives: " + str(_current_lives)
    else:
        _lives_label.text = "GAME OVER"

func _on_gained_life() -> void:
    _current_lives = min(_current_lives + 1, _initial_lives)
    _lives_label.text = "Lives: " + str(_current_lives)

func _on_increased_score(amount: int) -> void:
    _current_score += amount
    _score_label.text = "Score: " + str(_current_score)
