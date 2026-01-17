extends Node2D

@onready var button: Button = $Computer/Button
@onready var computer: Sprite2D = $Computer
@onready var password_1: Label = $password1
@onready var password_2: Label = $password2
@onready var password_3: Label = $password3
@onready var land: Label = $land

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	password_1.hide()
	password_2.hide()
	password_3.hide()
	land.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_button_up() -> void:
	var texture = load("res://assets/redScreen.png")
	computer.texture = texture
	button.hide()
	password_1.show()
	password_2.show()
	password_3.show()
	land.show()
