# password_categorizer.gd
# Attach this to a Control node as the root of your scene
extends Control

# Password database with varying strengths
var passwords = [
	# WEAK passwords
	{"text": "password", "strength": "weak", "reason": "Common dictionary word"},
	{"text": "12345678", "strength": "weak", "reason": "Sequential numbers"},
	{"text": "qwerty", "strength": "weak", "reason": "Keyboard pattern"},
	{"text": "admin", "strength": "weak", "reason": "Default credential"},
	{"text": "letmein", "strength": "weak", "reason": "Common phrase"},
	
	# MEDIUM passwords
	{"text": "Password123", "strength": "medium", "reason": "Dictionary + numbers"},
	{"text": "Summer2024!", "strength": "medium", "reason": "Pattern + symbol"},
	{"text": "JohnDoe85", "strength": "medium", "reason": "Name + year"},
	{"text": "Blue$Car99", "strength": "medium", "reason": "Words + substitution"},
	{"text": "Welcome@Home", "strength": "medium", "reason": "Predictable pattern"},
	
	# STRONG passwords
	{"text": "X7$mK9@pL2#nQ4", "strength": "strong", "reason": "High entropy, random"},
	{"text": "Tr!92kL#mP4xZ", "strength": "strong", "reason": "True randomness"},
	{"text": "9#Qs2@Lp7$Wn5", "strength": "strong", "reason": "Mixed characters"},
	{"text": "K3!nM8@pR5#Yx", "strength": "strong", "reason": "No patterns"},
	{"text": "V2$dF9@sL4#Gp", "strength": "strong", "reason": "Complex mix"}
]

# Nodes
@onready var password_pool = $MarginContainer/VBoxContainer/HSplitContainer/LeftPanel/ScrollContainer/PasswordPool
@onready var weak_zone = $MarginContainer/VBoxContainer/HSplitContainer/RightPanel/VBoxContainer/WeakZone/DropArea
@onready var medium_zone = $MarginContainer/VBoxContainer/HSplitContainer/RightPanel/VBoxContainer/MediumZone/DropArea
@onready var strong_zone = $MarginContainer/VBoxContainer/HSplitContainer/RightPanel/VBoxContainer/StrongZone/DropArea
@onready var feedback_label = $MarginContainer/VBoxContainer/FeedbackPanel/FeedbackLabel
@onready var next_button = $MarginContainer/VBoxContainer/FeedbackPanel/NextButton
@onready var reset_button = $MarginContainer/VBoxContainer/FeedbackPanel/ResetButton

# Preload password card scene
var PasswordCard = preload("res://password_card.tscn")

func _ready():
	# Shuffle passwords for variety
	passwords.shuffle()
	
	# Create password cards
	populate_password_pool()
	
	# Setup drop zones
	setup_drop_zones()
	
	# Connect buttons
	next_button.pressed.connect(_on_next_pressed)
	reset_button.pressed.connect(_on_reset_pressed)
	
	# Initial state
	next_button.disabled = true
	feedback_label.text = "Drag passwords to the correct strength categories"

func populate_password_pool():
	# Clear existing
	for child in password_pool.get_children():
		child.queue_free()
	
	# Create cards
	for pwd_data in passwords:
		var card = PasswordCard.instantiate()
		card.setup(pwd_data)
		card.card_dropped.connect(_on_card_dropped)
		password_pool.add_child(card)

func setup_drop_zones():
	# Make drop zones accept drops
	for zone in [weak_zone, medium_zone, strong_zone]:
		zone.custom_minimum_size = Vector2(300, 200)

func _on_card_dropped(card, zone_name: String):
	# Validate the drop
	var is_correct = validate_drop(card.password_data, zone_name)
	
	if is_correct:
		card.mark_correct()
		check_completion()
	else:
		card.mark_incorrect()
		# Return to pool after brief delay
		await get_tree().create_timer(1.0).timeout
		return_to_pool(card)

func validate_drop(password_data: Dictionary, zone_name: String) -> bool:
	var expected_strength = password_data.strength
	
	match zone_name:
		"weak":
			return expected_strength == "weak"
		"medium":
			return expected_strength == "medium"
		"strong":
			return expected_strength == "strong"
	
	return false

func return_to_pool(card):
	card.reset_state()
	# Move back to original parent
	var current_parent = card.get_parent()
	if current_parent:
		current_parent.remove_child(card)
	password_pool.add_child(card)

func check_completion():
	# Count correctly placed passwords
	var weak_correct = count_correct_in_zone(weak_zone, "weak")
	var medium_correct = count_correct_in_zone(medium_zone, "medium")
	var strong_correct = count_correct_in_zone(strong_zone, "strong")
	
	# Expected counts (from our password database)
	var weak_expected = passwords.filter(func(p): return p.strength == "weak").size()
	var medium_expected = passwords.filter(func(p): return p.strength == "medium").size()
	var strong_expected = passwords.filter(func(p): return p.strength == "strong").size()
	
	# Update feedback
	feedback_label.text = "Progress: Weak %d/%d | Medium %d/%d | Strong %d/%d" % [
		weak_correct, weak_expected,
		medium_correct, medium_expected,
		strong_correct, strong_expected
	]
	
	# Check if all correct
	if weak_correct == weak_expected and medium_correct == medium_expected and strong_correct == strong_expected:
		feedback_label.text = "[color=green]PERFECT! All passwords categorized correctly![/color]"
		next_button.disabled = false
		show_success_animation()

func count_correct_in_zone(zone: Control, expected_strength: String) -> int:
	var count = 0
	for child in zone.get_children():
		if child.has_method("get_password_data"):
			var data = child.get_password_data()
			if data.strength == expected_strength:
				count += 1
	return count

func show_success_animation():
	# Simple pulse animation
	var tween = create_tween()
	tween.tween_property(feedback_label, "scale", Vector2(1.1, 1.1), 0.3)
	tween.tween_property(feedback_label, "scale", Vector2(1.0, 1.0), 0.3)

func _on_next_pressed():
	print("Proceeding to next challenge...")
	# Load next scene or trigger next challenge
	# get_tree().change_scene_to_file("res://next_challenge.tscn")
	feedback_label.text = "Next challenge would load here!"

func _on_reset_pressed():
	# Reset the entire puzzle
	for zone in [weak_zone, medium_zone, strong_zone]:
		for child in zone.get_children():
			if child.has_method("reset_state"):
				child.queue_free()
	
	populate_password_pool()
	next_button.disabled = true
	feedback_label.text = "Drag passwords to the correct strength categories"
