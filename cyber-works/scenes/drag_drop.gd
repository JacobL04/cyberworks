class_name DragDropGrid
extends GridContainer

# Re-emit the signal so external scripts (like InventoryManager) can listen to one place
signal dragged(from_pos: Vector2i, to_pos: Vector2i)

# Optional: Store cells in a 2D array for easy access by coordinates
var cells: Array = []

func _ready() -> void:
	# Initialize the 2D array structure based on column count
	for i in columns:
		cells.append([])
	
	var current_row := 0
	var current_col := 0
	
	# Loop through all Button children
	for child in get_children():
		if child is DragDropCell:
			# Add child to our 2D array helper
			cells[current_col].append(child)
			
			# Assign the coordinate to the cell
			child.grid_position = Vector2i(current_col, current_row)
			
			# Connect the cell's signal to this script's signal
			# When the cell emits 'dragged', this script will also emit 'dragged'
			child.dragged.connect(dragged.emit)
			
			# Move to the next grid position
			current_col += 1
			if current_col >= columns:
				current_col = 0
				current_row += 1
