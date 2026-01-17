extends CanvasLayer

const readRate = 0.1

@onready var textbox_container: MarginContainer = $TextboxContainer
@onready var arrow: Label = $TextboxContainer/Panel/Arrow
@onready var label: Label = $TextboxContainer/Panel/Label

enum State {
	READY,
	READING,
	FINISHED
}

var curr_state = State.READY
var tween = create_tween()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_textbox()
	add_text("This text is gonna be added")
	
func _process(delta):
	match curr_state:
		State.READY:
			pass
		State.READING:
			pass
		State.FINISHED:
			pass

func hide_textbox():
	arrow.text = ""
	label.text = ""
	textbox_container.hide()
	
func show_textbox():
	arrow.text = "v"
	textbox_container.show()
	
func add_text(next_text):
	label.text = next_text
	show_textbox()
	tween.tween_property(label, "visible_ratio", 1.0, len(next_text)*readRate)
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	
func changeState(next_state):
	curr_state = next_state
	match curr_state:
		State.READY:
			pass
		State.READING:
			pass
		State.FINISHED:
			pass
