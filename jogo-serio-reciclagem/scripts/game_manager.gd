extends Node

const TOTAL_ROUNDS := 5

var materials: Array[Dictionary] = []
var current_round := 0
var score := 0
var correct_answers := 0
var current_material : Dictionary = {}
var audio_enabled := true

func _ready() -> void:
	_load_materials()
	
func _load_materials() -> void:
	var file := FileAccess.open("res://data/materials.json",FileAccess.READ)
	if file == null:
		push_error("Não foi possível abrir data/materials.json")
		return
		file.close()
	
	var parsed = JSON.parse_string(file.get_as_text())
	if parsed is Array:
		materials.assign(parsed)
	else:
		push_error("materials.json possui formato inválido")
		
func start_game() -> void:
	current_round = 0
	score = 0
	correct_answers= 0
	materials.shuffle()
	next_round()
	
func next_round() -> void:
	if current_round >= TOTAL_ROUNDS:
		return
	
	current_material = materials[current_round % materials.size()]
	current_round += 1
	
func answer(category_id: String) -> Dictionary:
	var is_correct := category_id == String(current_material.get("categoria",""))
	if is_correct:
		score += 10
		correct_answers += 1
		
	return{
		"correct_answers":is_correct,
		"score": score,
		"message": String(current_material.get("mensagem","")),
		"material_name": String(current_material.get("nome","")),
		"finished": current_round >= TOTAL_ROUNDS
	}
	
func is_finished() -> bool:
	return current_round >= TOTAL_ROUNDS
	
func get_result_message() -> String:
	if correct_answers == TOTAL_ROUNDS:
		return "Excelente Você separou todos os materiais."
	if correct_answers >= 3:
		return "Muito bem! Continue observando o material antes de descartar."
	return "Cada tentativa ensina algo novo. Vamos aprender mais sobre a separação do lixo."
	
	
