extends Node2D

signal switch_underworld
signal switch_world

func _ready():
	$Underworld.visible = false
	$Ghost.visible = false
	for human in $Humans.get_children():
		human.connect("die", self, "_switch_underworld", [human])
		
	$Ghost.connect("enter_body", self, "_switch_world")
	
func _switch_underworld(human):
	emit_signal("switch_underworld")
	$Ghost.out(human)
	$Underworld.show()
	
func _switch_world():
	emit_signal("switch_world")
	$Ghost.hide()
	$Underworld.hide()
	