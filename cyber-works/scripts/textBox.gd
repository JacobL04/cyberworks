#extends CanvasLayer
#
#const readRate = 0.1
#
#@onready var textbox_container: MarginContainer = $TextboxContainer
#@onready var arrow: Label = $TextboxContainer/Panel/Arrow
#@onready var label: Label = $TextboxContainer/Panel/Label
#
#enum State {
	#READY,
	#READING,
	#FINISHED
#}
#
#var curr_state = State.READY
#var textQueue = []
#var tween : Tween
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#hide_textbox()
	#queueText("first")
	#queueText("second")
	#queueText("third	")
	#
#func _process(_delta):
	#match curr_state:
		#State.READY:
			#if !textQueue.is_empty():
				#display_text()
		#State.READING:
			#if Input.is_action_just_pressed("ui_accept"):
				#label.visible_ratio = 1.0
				#if tween:
					#tween.kill()
				#arrow.text = "v"
				#changeState(State.FINISHED)
		#State.FINISHED:
			#if Input.is_action_just_pressed("ui_accept"):
				#changeState(State.READY)
				#hide_textbox()
#
#func queueText(next_text):
	#textQueue.push_back(next_text)
#
#func hide_textbox():
	#arrow.text = ""
	#label.text = ""
	#textbox_container.hide()
	#
#func show_textbox():
	#textbox_container.show()
	#
#func display_text():
	#var next_text = textQueue.pop_front()
	#label.text = next_text
	#label.visible_ratio = 0.0
	#show_textbox()
	#changeState(State.READING)
	#if tween:
		#tween.kill()
	#tween = create_tween()
	#tween.tween_property(label, "visible_ratio", 1.0, len(next_text)*readRate)
	#tween.set_ease(Tween.EASE_IN)
	#tween.set_trans(Tween.TRANS_LINEAR)
	#tween.finished.connect(on_tween_finished)
#
#func on_tween_finished():
	#arrow.text = "v"
	#changeState(State.FINISHED)
#
#func changeState(next_state):
	#curr_state = next_state
	#match curr_state:
		#State.READY:
			#print("change state to ready")
		#State.READING:
			#print("change state to reading ")
		#State.FINISHED:
			#print("change state to finished")

extends CanvasLayer

signal dialogue_finished

const READ_RATE := 0.1

@onready var textbox_container: MarginContainer = $TextboxContainer
@onready var arrow: Label = $TextboxContainer/Panel/Arrow
@onready var label: Label = $TextboxContainer/Panel/Label

enum State {
	READY,
	READING,
	FINISHED
}

var curr_state: State = State.READY
var text_queue: Array[String] = []
var tween: Tween


func _ready() -> void:
	hide_textbox()


func _process(_delta: float) -> void:
	match curr_state:
		State.READY:
			if text_queue.is_empty():
				hide_textbox()
				emit_signal("dialogue_finished")
			else:
				display_text()

		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				label.visible_ratio = 1.0
				if tween:
					tween.kill()
				arrow.text = "v"
				change_state(State.FINISHED)

		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
				change_state(State.READY)


# ---------- PUBLIC API ----------

func start_dialogue(lines: Array[String]) -> void:
	text_queue.clear()
	for line in lines:
		text_queue.push_back(line)
	change_state(State.READY)


# ---------- INTERNAL ----------

func hide_textbox() -> void:
	arrow.text = ""
	label.text = ""
	textbox_container.hide()


func show_textbox() -> void:
	textbox_container.show()


func display_text() -> void:
	var next_text: String = text_queue.pop_front()  # explicitly typed

	label.text = next_text
	label.visible_ratio = 0.0
	show_textbox()

	change_state(State.READING)

	if tween:
		tween.kill()

	tween = create_tween()
	tween.tween_property(
		label,
		"visible_ratio",
		1.0,
		next_text.length() * READ_RATE
	)
	tween.finished.connect(_on_tween_finished)


func _on_tween_finished() -> void:
	arrow.text = "v"
	change_state(State.FINISHED)


func change_state(next_state: State) -> void:
	curr_state = next_state
