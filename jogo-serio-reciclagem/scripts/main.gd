extends Node

@onready var screen_container: Control = $ScreenContainer

const TITLE_SCREEN := preload("res://scenes/title_screen.tscn")
const INSTRUCTIONS_SCREEN := preload("res://scenes/instructions_screen.tscn")
const GAME_SCREEN := preload("res://scenes/game_screen.tscn")
const RESULT_SCREEN := preload("res://scenes/result_screen.tscn")

func _ready() -> void: 
	show_title()
	
func _replace_screen(scene: PackedScene) -> void:
	for child in screen_container.get_children():
		child.queue_free()
	var instance := scene.instantiate()
	screen_container .add_child(instance)
	
func show_title() -> void:
	_replace_screen(TITLE_SCREEN)
	
func show_instructions() -> void:
	_replace_screen(INSTRUCTIONS_SCREEN)

func show_game() -> void:
	GameManager.start_game()
	_replace_screen(GAME_SCREEN)
	
func show_result() -> void:
	_replace_screen(RESULT_SCREEN)
	
