extends Node2D

@export var correctUsername: String = "or 1==1"
@onready var username: LineEdit = $username

var animation_tween: Tween

func _ready() -> void:
	username.text_submitted.connect(_on_text_edit_text_submitted)
	$Button.pressed.connect(_on_button_pressed)

func _on_text_edit_text_submitted(new_text: String) -> void:
	checkAns(new_text)
	
func _on_button_pressed():
	# If using a button, we need to grab the text manually
	checkAns(username.text)
	
func checkAns(input_text: String):
	if input_text == correctUsername:
		unlockSuccess()
	else:
		unlockFail()
		
func unlockSuccess():
	print("access granted")
	
func unlockFail():
	username.clear()
	flash_error()

func flash_error():
	# 1. If an animation is already playing, stop it so we can restart
	if animation_tween:
		animation_tween.kill()
	
	# 2. Create a new Tween
	animation_tween = create_tween()
	
	# 3. INSTANTLY turn the box Red (over 0.0 seconds)
	# We use "modulate" to tint the node
	animation_tween.tween_property(username, "modulate", Color(1, 0, 0), 0.0)
	
	# 4. SLOWLY fade back to White (normal) over 0.5 seconds
	# We use Color.WHITE (which is default/no tint)
	animation_tween.tween_property(username, "modulate", Color.WHITE, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
