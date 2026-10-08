extends  Control

signal  play_requested
signal instructions_requested

@onready var play_button: Button = $VBoxContainer/PlayButton
@onready var instructions_buttons: Button = $VBoxContainer/InstructionsButton

func _ready() -> void:
	play_button.pressed.connect(func(): play_requested.emit())
	instructions_buttons.pressed.connect(func(): instructions_requested.emit())
	play_button.grab_focus()
