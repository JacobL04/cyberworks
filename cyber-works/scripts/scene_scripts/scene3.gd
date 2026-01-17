extends Node

@onready var textbox := $TextBox


func _ready() -> void:
	start_cutscene()


func start_cutscene() -> void:
	var dialogue: Array[String] = [
		"ERROR",
		"...",
		"Strange..",
		"No access.",
		"You get dressed and head to the office...",
	]

	textbox.start_dialogue(dialogue)
	textbox.dialogue_finished.connect(_on_dialogue_finished)


func _on_dialogue_finished() -> void:
	print("Dialogue finished!")
	get_tree().change_scene_to_file("res://scenes/intro_cutscenes/scene4.tscn")
