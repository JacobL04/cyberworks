extends CanvasLayer

@onready var textbox_container: MarginContainer = $TextboxContainer
@onready var arrow: Label = $TextboxContainer/Panel/Arrow
@onready var label: Label = $TextboxContainer/Panel/Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_textbox()
	add_text("This text is gonna be added")

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
