class_name DragDropCell
extends Button

# Stores the grid coordinate of this specific cell (e.g., (0,0), (1,2))
var grid_position := Vector2i.ZERO

# Signal sent when a drop is successfully completed
signal dragged(from_pos: Vector2i, to_pos: Vector2i)

# Called when the player clicks and starts moving the mouse
func _get_drag_data(_at_position: Vector2) -> Variant:
	# Don't allow dragging if the slot is empty
	if not icon:
		return null
	
	# Create the ghost preview image that follows the mouse
	var preview = TextureRect.new()
	preview.texture = icon
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview.size = Vector2(50, 50) # Adjust size to match your grid cells
	
	# Center the preview on the mouse cursor
	preview.position = -preview.size / 2
	
	# Set the preview and return this button node as the "data"
	set_drag_preview(preview)
	return self

# Called every frame while dragging over this button
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	# Only allow dropping if the data is a DragDropCell and not the same cell we started from
	return data is DragDropCell and data != self

# Called when the mouse button is released
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	# Swap the icons (textures)
	var temp_icon = icon
	icon = data.icon
	data.icon = temp_icon
	
	# Notify the system that a swap occurred
	dragged.emit(data.grid_position, grid_position)
