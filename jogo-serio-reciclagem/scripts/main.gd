extends Node

@onready var screen_container: Control = $ScreenContainer

const TITLE_SCREEN := preload("res://scenes/title_screen.tscn")
const INSTRUCTIONS_SCREEN := preload("res://scenes/instructions_screen.tscn")
const GAME_SCREEN := preload("res://scenes/game_screen.tscn")
const RESULT_SCREEN := preload("res://scenes/result_screen.tscn")

func _ready() -> void:
	show_title()

func _replace_screen(scene: PackedScene) -> Control:
	for child in screen_container.get_children():
		child.queue_free()

	var new_screen := scene.instantiate() as Control
	screen_container.add_child(new_screen)
	return new_screen

func show_title() -> void:
	var screen := _replace_screen(TITLE_SCREEN)
	screen.play_requested.connect(show_instructions)
	screen.instructions_requested.connect(show_instructions)

func show_instructions() -> void:
	var screen := _replace_screen(INSTRUCTIONS_SCREEN)
	screen.continue_requested.connect(show_game)

func show_game() -> void:
	GameManager.start_game()
	var screen := _replace_screen(GAME_SCREEN)
	screen.result_requested.connect(show_result)

func show_result() -> void:
	var screen := _replace_screen(RESULT_SCREEN)
	screen.play_again_requested.connect(show_game)
	screen.home_requested.connect(show_title)
