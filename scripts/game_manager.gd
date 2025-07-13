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
    EventBus.lost_life.connect(on_life_lost)
    EventBus.increased_score.connect(on_score_increased)

func on_life_lost() -> void:
    _current_lives -= 1

    if _current_lives > 0:
        _lives_label.text = "Lives: " + str(_current_lives)
    else:
        _lives_label.text = "GAME OVER"

func on_score_increased(amount: int) -> void:
    _current_score += amount
    _score_label.text = "Score: " + str(_current_score)
