extends Label

func _get_drag_data(_at_position):
	# 1. Prepare the data to transfer (just the text string this time)
	var drag_data = {
		"text": text,
		"origin_label": self
	}
	
	# 2. Create the visual preview (Ghost text)
	var preview_label = Label.new()
	preview_label.text = text
	preview_label.add_theme_font_size_override("font_size", get_theme_font_size("font_size"))
	
	# Center the preview on the mouse cursor
	var preview_control = Control.new()
	preview_control.add_child(preview_label)
	# Center offset (approximate based on text size)
	preview_label.position = -0.5 * preview_label.size
	
	set_drag_preview(preview_control)
	
	return drag_data
