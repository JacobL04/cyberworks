extends Node2D

@onready var start_but: TextureButton = $StartBut
@onready var settings_but: TextureButton = $SettingsBut
@onready var quit_but: TextureButton = $QuitBut

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_start_but_button_up() -> void:
	pass # Replace with function body.

func _on_settings_but_button_up() -> void:
	pass # Replace with function body.

func _on_quit_but_button_up() -> void:
	pass # Replace with function body.



func _on_start_but_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/intro_cutscenes/scene1.tscn")

func _on_quit_but_pressed() -> void:
	get_tree().quit()
