extends Node

@onready var textbox := $TextBox
@onready var fade: CanvasLayer = $Fade


func _ready() -> void:
	start_cutscene()


func start_cutscene() -> void:
	var dialogue: Array[String] = [
		"You wake up on a Monday morning.",
		"Another day at the office.",
	    "You get dressed and head to the building..."
	]

	textbox.start_dialogue(dialogue)
	textbox.dialogue_finished.connect(_on_dialogue_finished)


func _on_dialogue_finished() -> void:
	print("Dialogue finished!")
	#await fade.fade(1.0, 1.5).finished
	get_tree().change_scene_to_file("res://scenes/intro_cutscenes/scene2.tscn")
