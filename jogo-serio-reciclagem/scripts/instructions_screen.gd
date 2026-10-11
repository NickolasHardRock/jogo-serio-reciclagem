extends Control

signal  continue_requested

@onready var continue_button: Button = $VBoxContainer/ContinueButton

func _ready() -> void:
	continue_button.pressed.connect(func(): continue_requested.emit())
	continue_button.grab_focus()
