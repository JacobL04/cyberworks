extends Label

func _can_drop_data(_at_position, data):
	# Check if the incoming data has a "text" key
	if typeof(data) == TYPE_DICTIONARY and data.has("text"):
		return true
	return false

func _drop_data(_at_position, data):
	# Update this label's text to match the dragged text
	text = data["text"]
	if text == "P1@s5w0rD":
		Main.toMoralChoice()

	else:
		print("wrong")
		text = "Wrong password"
		show()
