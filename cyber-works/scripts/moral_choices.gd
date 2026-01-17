extends Node2D

@onready var progress_bar: TextureProgressBar = $ProgressBar
@onready var button: Button = $Button
@onready var button_2: Button = $Button2
@onready var button_3: Button = $Button3
@onready var button_4: Button = $Button4
@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress_bar.value = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Main.moralChoices == true:
		progress_bar.value -= 1

func _on_button_button_up() -> void:
	Main.moral += 2

func _on_button_2_button_up() -> void:
	Main.moral += 1

func _on_button_3_button_up() -> void:
	Main.moral -= 1

func _on_button_4_button_up() -> void:
	Main.moral -= 2
