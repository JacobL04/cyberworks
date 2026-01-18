extends CanvasLayer

signal dialogue_finished

const READ_RATE := 0.05

@onready var textbox_container: MarginContainer = $TextboxContainer
@onready var arrow: Label = $TextboxContainer/Panel/Arrow
@onready var label: Label = $TextboxContainer/Panel/Label
@onready var discord_head: Sprite2D = $frame/DiscordHead
@onready var riley_head: Sprite2D = $frame/RileyHead
@onready var frame: Sprite2D = $frame

enum State {
	READY,
	READING,
	FINISHED
}

const SPEAKER_COLORS := {
	"discord": Color(0.9, 0.2, 0.2), # red
	"riley": Color(0.3, 0.6, 1.0),   # blue
	"none": Color.WHITE,
	"effect": Color.DARK_ORANGE
}


var curr_state: State = State.READY
var text_queue: Array[Dictionary] = []
var tween: Tween


func _ready() -> void:
	hide_textbox()
	riley_head.hide()
	discord_head.hide()


func _process(_delta: float) -> void:
	match curr_state:
		State.READY:
			if text_queue.is_empty():
				hide_textbox()
				emit_signal("dialogue_finished")
			else:
				display_text()

		State.READING:
			if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("m1"):
				label.visible_ratio = 1.0
				if tween:
					tween.kill()
				arrow.text = "v"
				change_state(State.FINISHED)

		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("m1"):
				change_state(State.READY)


# ---------- PUBLIC API ----------

func start_dialogue(lines: Array) -> void:
	text_queue.clear()
	for line in lines:
		text_queue.push_back(line)
	change_state(State.READY)


# ---------- INTERNAL ----------

func hide_textbox() -> void:
	arrow.text = ""
	label.text = ""
	textbox_container.hide()
	frame.hide()


func show_textbox() -> void:
	textbox_container.show()
	frame.show()


func display_text() -> void:
	var entry: Dictionary = text_queue.pop_front()
	var next_text: String = entry["text"]
	var speaker: String = entry["speaker"]

	update_speaker(speaker)

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
	
func update_speaker(speaker: String) -> void:
	discord_head.hide()
	riley_head.hide()

	set_text_color(SPEAKER_COLORS.get(speaker, Color.WHITE))


	match speaker:
		"discord":
			discord_head.show()
		"riley":
			riley_head.show()
		"effect":
			pass
		"none":
			pass

func set_text_color(color: Color) -> void:
	var t := create_tween()
	t.tween_property(label, "modulate", color, 0.2)
