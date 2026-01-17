extends Node2D

@onready var button: Button = $Button

func _on_button_button_up() -> void:
	Main.toEmail()
