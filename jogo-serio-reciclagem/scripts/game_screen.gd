extends Control

signal result_requested

@onready var round_label: Label = $MarginContainer/VBoxContainer/Header/RoundLabel
@onready var score_label: Label = $MarginContainer/VBoxContainer/Header/ScoreLabel
@onready var material_image: TextureRect = $MarginContainer/VBoxContainer/MaterialPanel/MaterialImage
@onready var material_name: Label = $MarginContainer/VBoxContainer/MaterialPanel/MaterialName
@onready var feedback_panel: PanelContainer = $MarginContainer/VBoxContainer/FeedbackPanel
@onready var feedback_label: Label = $MarginContainer/VBoxContainer/FeedbackPanel/FeedbackLabel
@onready var category_grid: GridContainer = $MarginContainer/VBoxContainer/CategoryGrid

var answer_locked := false

func _ready() -> void:
	_connect_category_buttons()
	feedback_panel.hide()
	_show_current_round()
	

func _connect_category_buttons() -> void:
	for button in category_grid.get_children():
		if button is Button:
			button.pressed.connect(_on_category_pressed.bind(button.get_meta("category_id")))

func _show_current_round() -> void:
	answer_locked = false
	var material := GameManager.current_material
	round_label.text = "Rodada %d de %d" % [GameManager.current_round, GameManager.TOTAL_ROUNDS]
	score_label.text = "Pontos: %d" % GameManager.score
	material_name.text = String(material.get("nome","Material"))
	feedback_panel.hide()
	
	var image_path := String(material.get("imagem",""))
	if ResourceLoader.exists(image_path):
		material_image.texture = load(image_path)
	for button in category_grid.get_children():
		if button is Button:
			button.disabled = false 
			button.grab_focus() if button == category_grid.get_child(0) else null

func _on_category_pressed(category_id:String) -> void:
	if answer_locked:
		return
	
	answer_locked = true
	var result := GameManager.answer(category_id)
	score_label.text = "Pontos: %d" % GameManager.score
	
	if result.correct:
		feedback_label.text = "Muito bem! %s" % result.message
	else:
		feedback_label.text = "Quase! A resposta correta é outra. %s" % result.message
	
	feedback_panel.show()
	_disable_categories()
	
	await get_tree().create_timer(1.5).timeout
	if result.finished: 
		result_requested.emit()
	else:
		GameManager.next_round()
		_show_current_round()
	
func _disable_categories() -> void:
	for button in category_grid.get_children():
		if button is Button:
			button.disabled = true
