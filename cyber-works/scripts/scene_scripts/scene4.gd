extends Node

@onready var textbox := $TextBox
@onready var moral_label: Label = $MoralLabel


func _ready() -> void:
	print("Your final moral score was: ", Main.moral)
	update_moral_label()


func _on_quit_but_pressed() -> void:
	get_tree().quit()
	
	
func update_moral_label():
	var moral = Main.moral
	
	if moral > 5:
		moral_label.text = "GOOD ("+ str(moral) +")"
		moral_label.modulate = Color.GREEN
		
	elif moral < -5:
		moral_label.text = "BAD ("+ str(moral) +")"
		moral_label.modulate = Color.RED
		
	else:
		moral_label.text = "NEUTRAL ("+ str(moral) +")"
		moral_label.modulate = Color.YELLOW
