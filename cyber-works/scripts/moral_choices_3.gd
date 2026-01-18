extends Node2D

@onready var button: TextureButton = $Button
@onready var button_2: TextureButton = $Button2
@onready var button_3: TextureButton = $Button3
@onready var questions: Label = $Questions
@onready var progress_bar: TextureProgressBar = $ProgressBar

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	progress_bar.value -= 1
	if progress_bar.value == 0:
		Main.moral += randi_range(-2, 2)
		Main.toComputer()

func _on_button_button_up() -> void:
	Main.moral += 2
	Main.toMainInterface()

func _on_button_2_button_up() -> void:
	Main.toMainInterface()

func _on_button_3_button_up() -> void:
	Main.moral -= 2
	Main.toMainInterface()
