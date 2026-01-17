extends Node

@onready var textbox := $TextBox


func _ready() -> void:
	start_cutscene()


func start_cutscene() -> void:
	var dialogue: Array[String] = [
		"You realized your identity has been stolen!",
		"Your goal is to retrieve the missing pieces",
	]

	textbox.start_dialogue(dialogue)
	textbox.dialogue_finished.connect(_on_dialogue_finished)


func _on_dialogue_finished() -> void:
	print("Dialogue finished!")
	get_tree().change_scene_to_file("res://scenes/unlock.tscn")
