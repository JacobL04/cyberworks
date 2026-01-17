extends Control

# Configuration
var files_to_deploy = [
	{
		"name": "Data.zip",
		"path": "res://challenge-files/data.zip",
		# Same Y (400) puts them on the same level. Different X (300 vs 500) separates them.
		"pos": Vector2(180, 300), 
		"icon": preload("res://assets/fileBut.png")
	},
	{
		"name": "Network.pcap",
		"path": "res://challenge-files/network.pcap",
		"pos": Vector2(300, 300), 
		"icon": preload("res://assets/fileBut.png")
	}
]

var animation_tween: Tween
var current_target_file_path = ""

@export var correctAns: String = "opsecworks#$+"
@onready var text_edit: LineEdit = $LineEdit
@onready var files_container = $FilesContainer
@onready var save_dialog = $SaveDialog

func _ready():
	setup_save_dialog()
	create_desktop_icons()
	text_edit.text_submitted.connect(_on_text_edit_text_submitted)


func setup_save_dialog():
	save_dialog.file_selected.connect(_on_save_dialog_file_selected)
	save_dialog.always_on_top = true

func create_desktop_icons():
	for file_data in files_to_deploy:
		var btn = Button.new()
		
		# 1. Visuals & Icon
		btn.text = file_data["name"]
		btn.icon = file_data["icon"]
		btn.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
		btn.vertical_icon_alignment = VERTICAL_ALIGNMENT_TOP
		btn.flat = true 
		
		# 2. FORCE BLACK TEXT
		# We override the font colors for all button states (normal, hover, pressed)
		btn.add_theme_color_override("font_color", Color.BLACK)
		btn.add_theme_color_override("font_hover_color", Color.DARK_SLATE_GRAY)
		btn.add_theme_color_override("font_pressed_color", Color.BLACK)
		btn.add_theme_color_override("font_focus_color", Color.BLACK)
		
		# 3. Positioning
		btn.custom_minimum_size = Vector2(150, 120)
		btn.position = file_data["pos"]
		
		# 4. Logic
		btn.pressed.connect(_on_file_button_pressed.bind(file_data["name"], file_data["path"]))
		
		files_container.add_child(btn)

func _on_file_button_pressed(file_name: String, file_path: String):
	current_target_file_path = file_path
	save_dialog.current_file = file_name
	save_dialog.title = "Download " + file_name
	save_dialog.popup_centered()

func _on_save_dialog_file_selected(destination_path):
	extract_file_to_system(current_target_file_path, destination_path)

func extract_file_to_system(source_path, destination_path):
	if not FileAccess.file_exists(source_path):
		printerr("Error: Source file missing at " + source_path)
		return

	var source_file = FileAccess.open(source_path, FileAccess.READ)
	var content_buffer = source_file.get_buffer(source_file.get_length())
	
	var dest_file = FileAccess.open(destination_path, FileAccess.WRITE)
	if dest_file:
		dest_file.store_buffer(content_buffer)
		dest_file.close()
		print("Success! Saved to: " + destination_path)
	else:
		printerr("Error: Check folder permissions.")

func _on_text_edit_text_submitted(new_text: String) -> void:
	checkAns(new_text)

func checkAns(input_text: String):
	if input_text == correctAns:
		unlockSuccess()
	else:
		unlockFail()
		
func unlockSuccess():
	Main.toMoralChoice4()
	
func unlockFail():
	text_edit.clear()
	flash_error()

func flash_error():
	# 1. If an animation is already playing, stop it so we can restart
	if animation_tween:
		animation_tween.kill()
	
	# 2. Create a new Tween
	animation_tween = create_tween()
	
	# 3. INSTANTLY turn the box Red (over 0.0 seconds)
	# We use "modulate" to tint the node
	animation_tween.tween_property(text_edit, "modulate", Color(1, 0, 0), 0.0)
	
	# 4. SLOWLY fade back to White (normal) over 0.5 seconds
	# We use Color.WHITE (which is default/no tint)
	animation_tween.tween_property(text_edit, "modulate", Color.WHITE, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
