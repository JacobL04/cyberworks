extends StaticBody2D

var dragging := false

signal drag_signal

func _ready():
	drag_signal.connect(_set_drag)

func _process(delta):
	if dragging:
		global_position = get_global_mouse_position()

func _set_drag():
	dragging = !dragging

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			dragging = event.pressed
