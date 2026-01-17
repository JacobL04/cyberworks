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
var textQueue = []
var tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_textbox()
	queueText("first")
	queueText("second")
	queueText("third	")
	
func _process(_delta):
	match curr_state:
		State.READY:
			if !textQueue.is_empty():
				display_text()
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				label.visible_ratio = 1.0
				if tween:
					tween.kill()
				arrow.text = "v"
				changeState(State.FINISHED)
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
				changeState(State.READY)
				hide_textbox()

func queueText(next_text):
	textQueue.push_back(next_text)

func hide_textbox():
	arrow.text = ""
	label.text = ""
	textbox_container.hide()
	
func show_textbox():
	textbox_container.show()
	
func display_text():
	var next_text = textQueue.pop_front()
	label.text = next_text
	label.visible_ratio = 0.0
	show_textbox()
	changeState(State.READING)
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(label, "visible_ratio", 1.0, len(next_text)*readRate)
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.finished.connect(on_tween_finished)

func on_tween_finished():
	arrow.text = "v"
	changeState(State.FINISHED)

func changeState(next_state):
	curr_state = next_state
	match curr_state:
		State.READY:
			print("change state to ready")
		State.READING:
			print("change state to reading ")
		State.FINISHED:
			print("change state to finished")
