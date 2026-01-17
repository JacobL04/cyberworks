# drop_zone.gd
# Attach to a PanelContainer that serves as a drop area
extends PanelContainer

@export var zone_name: String = "weak"  # "weak", "medium", or "strong"
@export var zone_color: Color = Color(0.8, 0.2, 0.2, 0.2)

var default_style: StyleBoxFlat
var hover_style: StyleBoxFlat

func _ready():
	setup_styles()
	apply_default_style()

func setup_styles():
	# Default style
	default_style = StyleBoxFlat.new()
	default_style.bg_color = zone_color
	default_style.border_color = zone_color.lightened(0.3)
	default_style.border_width_left = 2
	default_style.border_width_right = 2
	default_style.border_width_top = 2
	default_style.border_width_bottom = 2
	default_style.corner_radius_top_left = 8
	default_style.corner_radius_top_right = 8
	default_style.corner_radius_bottom_left = 8
	default_style.corner_radius_bottom_right = 8
	
	# Hover style (brighter)
	hover_style = StyleBoxFlat.new()
	hover_style.bg_color = zone_color.lightened(0.2)
	hover_style.border_color = zone_color.lightened(0.5)
	hover_style.border_width_left = 3
	hover_style.border_width_right = 3
	hover_style.border_width_top = 3
	hover_style.border_width_bottom = 3
	hover_style.corner_radius_top_left = 8
	hover_style.corner_radius_top_right = 8
	hover_style.corner_radius_bottom_left = 8
	hover_style.corner_radius_bottom_right = 8

func apply_default_style():
	add_theme_stylebox_override("panel", default_style)

func apply_hover_style():
	add_theme_stylebox_override("panel", hover_style)

# Drop zone implementation
func _can_drop_data(_at_position: Vector2, data) -> bool:
	# Only accept PasswordCard nodes
	if data is PanelContainer and data.has_method("get_password_data"):
		apply_hover_style()
		return true
	return false

func _drop_data(_at_position: Vector2, data):
	apply_default_style()
	
	if data is PanelContainer and data.has_method("get_password_data"):
		var card = data
		
		# Remove from current parent
		var current_parent = card.get_parent()
		if current_parent:
			current_parent.remove_child(card)
		
		# Add to this drop zone
		add_child(card)
		
		# Notify the main scene
		card.card_dropped.emit(card, zone_name)

func _notification(what):
	if what == NOTIFICATION_DRAG_END:
		apply_default_style()


# Node structure for drop zones:
# Each strength category should have this structure:
#
# VBoxContainer (e.g., WeakZone)
# ├─ Label (title: "WEAK PASSWORDS")
# └─ DropArea (PanelContainer with drop_zone.gd)
#    └─ (cards will be added here dynamically)
#
# Set the zone_name export variable:
# - WeakZone/DropArea: zone_name = "weak"
# - MediumZone/DropArea: zone_name = "medium"  
# - StrongZone/DropArea: zone_name = "strong"
