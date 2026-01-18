extends Node2D

@onready var progress_bar: TextureProgressBar = $ProgressBar
@onready var button: TextureButton = $Button
@onready var button_2: TextureButton = $Button2
@onready var button_3: TextureButton = $Button3
@onready var label: Label = $Questions

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress_bar.value = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Main.moralChoices == true:
		progress_bar.value -= 1

func _on_button_button_up() -> void:
	Main.moral += 2
	Main.toComputer()

func _on_button_2_button_up() -> void:
	Main.toComputer()

func _on_button_3_button_up() -> void:
	Main.moral -= 2
	Main.toComputer()
