extends Node2D

var moral = 0

#gamestate
var moralChoices = false
var techChallenge = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	toStart()

#first moral choice
func toMoralChoice():
	get_tree().change_scene_to_file.call_deferred("res://scenes/moral_choices.tscn")

func toMoralChoice2():
	get_tree().change_scene_to_file.call_deferred("res://scenes/moral_choices2.tscn")

func toMoralChoice3():
	get_tree().change_scene_to_file.call_deferred("res://scenes/moral_choices3.tscn")

func toMoralChoice4():
	get_tree().change_scene_to_file.call_deferred("res://scenes/moral_choices4.tscn")

func toEmail():
	get_tree().change_scene_to_file.call_deferred("res://scenes/email.tscn")

func toEmailHome():
	get_tree().change_scene_to_file.call_deferred("res://scenes/email_home.tscn")

func toWebsite():
	get_tree().change_scene_to_file.call_deferred("res://scenes/website.tscn")

func toMainInterface():
	get_tree().change_scene_to_file.call_deferred("res://scenes/main_interface.tscn")

func toStart():
	get_tree().change_scene_to_file.call_deferred("res://scenes/start.tscn")

func toComputer():
	get_tree().change_scene_to_file.call_deferred("res://scenes/computer.tscn")
