extends Node2D

@onready var button: Button = $Control/Button
@onready var texture_rect: TextureRect = $TextureRect
@onready var timer: Timer = $TextureRect/Timer

func _ready() -> void:
	texture_rect.hide()


func _on_button_button_up() -> void:
	Main.toEmail()


func _on_very_cool_button_up() -> void:
	texture_rect.show()
	timer.start()

func _on_timer_timeout() -> void:
	texture_rect.hide()
