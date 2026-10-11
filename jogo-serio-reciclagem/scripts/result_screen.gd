extends Control

signal play_again_requested
signal home_requested

@onready var score_label: Label = $VBoxContainer/ScoreLabel
@onready var educational_message: Label = $VBoxContainer/EducationalMessage
@onready var play_again_button: Button = $VBoxContainer/PlayAgainButton
@onready var home_button: Button = $VBoxContainer/HomeButton

func _ready() -> void:
	score_label.text = "Você fez %d pontos de %d" % [GameManager.score, GameManager.TOTAL_ROUNDS * 10]
	educational_message.text = GameManager.get_result_message()
	play_again_button.pressed.connect(func(): play_again_requested.emit())
	home_button.pressed.connect(func(): home_requested.emit())
	play_again_button.grab_focus()
