extends Node2D

@export var correctAns: String = "www.opsecworks.com"
@export var correctAns2: String = "opsecworks.com"
@onready var text_edit: LineEdit = $TextEdit

var animation_tween: Tween

func _on_text_edit_text_submitted(new_text: String) -> void:
	checkAns(new_text)

func checkAns(input_text: String):
	if input_text == correctAns or correctAns2:
		unlockSuccess()
	else:
		unlockFail()
		
func unlockSuccess():
	Main.toMoralChoice2()
	
func unlockFail():
	text_edit.clear()
	flash_error()

func flash_error():
	# 1. If an animation is already playing, stop it so we can restart
	if animation_tween:
		animation_tween.kill()
	
	# 2. Create a new Tween
	animation_tween = create_tween()
	
	# 3. INSTANTLY turn the box Red (over 0.0 seconds)
	# We use "modulate" to tint the node
	animation_tween.tween_property(text_edit, "modulate", Color(1, 0, 0), 0.0)
	
	# 4. SLOWLY fade back to White (normal) over 0.5 seconds
	# We use Color.WHITE (which is default/no tint)
	animation_tween.tween_property(text_edit, "modulate", Color.WHITE, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
