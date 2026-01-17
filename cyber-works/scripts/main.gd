extends Node2D

var moral = 0

#gamestate
var moralChoices = false
var techChallenge = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().change_scene_to_file("res://start.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

#first moral choice
func toMoralChoice():
	get_tree().change_scene_to_file("res://scenes/moral_choices.tscn")
