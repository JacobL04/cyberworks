extends Node

@onready var textbox := $TextBox


func _ready() -> void:
	start_cutscene()


func start_cutscene() -> void:
	var dialogue := [
		{ "speaker": "effect", "text": "[ERROR]"},
		{ "speaker": "none", "text": "..."},
		{ "speaker": "riley", "text": "Strange.."},
		{ "speaker": "riley", "text": "No access."},
		{ "speaker": "riley", "text": "Something feels wrong."},
		{ "speaker": "discord", "text": "'Your identity has been stolen!'"},
		{ "speaker": "discord", "text": "'Someone is using your SIN.'"},
		{ "speaker": "none", "text": "All hope is not lost. It looks like the hacker left clues.."},
		{ "speaker": "effect", "text": "[Goal: You must recover it by solving cybersecruity challenges]"},
		{ "speaker": "effect", "text": "[And make ethical decisions.]",},
	]

	textbox.start_dialogue(dialogue)
	textbox.dialogue_finished.connect(_on_dialogue_finished)


func _on_dialogue_finished() -> void:
	print("Dialogue finished!")
	get_tree().change_scene_to_file("res://scenes/unlock.tscn")
