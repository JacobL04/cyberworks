extends Node

@onready var textbox := $TextBox

func _ready() -> void:
	start_cutscene()


func start_cutscene() -> void:
	var dialogue := [
		{ "speaker": "none", "text": "You wake up on a Monday morning." },
		{ "speaker": "effect", "text": "[~Ring]" },
		{ "speaker": "none", "text": "A notification blinks on your phone." },
		{ "speaker": "discord", "text": "'Check your online accounts Riley!'" },
		{ "speaker": "effect", "text": "[It's your online friend]" },
		{ "speaker": "discord", "text": "'It's urgent!" },
		{ "speaker": "none", "text": "You check your accounts.." },
		{ "speaker": "effect", "text": "[Unauthorized access detected.]" },
		{ "speaker": "effect", "text": "[Your credentials been compromised.]" },
		{ "speaker": "effect", "text": "[Your identity is no longer yours.]" },
	]


	textbox.start_dialogue(dialogue)
	textbox.dialogue_finished.connect(_on_dialogue_finished)


func _on_dialogue_finished() -> void:
	print("Dialogue finished!")
	get_tree().change_scene_to_file("res://scenes/intro_cutscenes/scene2.tscn")
