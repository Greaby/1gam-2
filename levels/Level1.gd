extends Node2D

func _ready():
	$Underworld.visible = false
	for human in $Humans.get_children():
		human.connect("die", self, "_switch_to_underworld", [human])
		
	$Ghost.connect("enter_body", self, "_switch_to_world")
	
func _switch_to_underworld(human):
	$Ghost.position = human.position
	$Ghost.show()
	$Underworld.show()
	
func _switch_to_world():
	$Ghost.hide()
	$Underworld.hide()
	