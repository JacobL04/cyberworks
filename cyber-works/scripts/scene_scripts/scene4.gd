extends Node

@onready var textbox := $TextBox
@onready var moral_label: Label = $MoralLabel


func _ready() -> void:
	print("Your final moral score was: ", Main.moral)
	update_moral_label()


func _on_quit_but_pressed() -> void:
	get_tree().quit()
	
@onready var description_label: Label = $Label2 

func update_moral_label():
	var moral = Main.moral
	
	if moral > 5:
		moral_label.text = "RESTORED IDENTITY"
		moral_label.modulate = Color.GREEN
		description_label.text = "
		Your integrity remains intact. 
		By choosing transparency over personal 
		gain, you didn't just recover your data-you
		saved your humanity.The system recognizes you
		once more,not as a collection of bits, but as
		a person of principle."
		
	elif moral < -5:
		moral_label.text = "FORGED IDENTITY"
		moral_label.modulate = Color.RED
		description_label.text = "
		You have your name back, 
		but at what cost? You used the tools 
		of your enemies to become one of them.
		The SIN number is the same, but the person
		behind it is a stranger. You aren't 
		recovered; you are redesigned."
		
	else:
		moral_label.text = "FRAGMENTED IDENTITY"
		moral_label.modulate = Color.YELLOW
		description_label.text = "
		You survived, but the process left scars.
		By walking the line between right and wrong,
		you've become a ghost in the machine-neithera hero 
		nor a villain. You have your life back,
		but part of you stayed behind in the code."
