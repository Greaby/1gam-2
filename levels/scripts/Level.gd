extends Node2D

signal level_complete
signal switch_underworld
signal switch_world

export (int) var human_required = 1

func _ready():
	$Underworld.visible = false
	$Ghost.visible = false
	for human in $Humans.get_children():
		human.connect("ghost_out", self, "_switch_underworld", [human])

	$Ghost.connect("enter_body", self, "_switch_world")
	
	$Monster.connect("human_eated", self, "_human_eated")

func _switch_underworld(human):
	emit_signal("switch_underworld")
	$Ghost.out(human)
	$Underworld.show()
	
func _switch_world():
	emit_signal("switch_world")
	$Underworld.hide()

func _human_eated(body):
	if($Monster.human_eated >= human_required):
		emit_signal("level_complete")
	else:
		_switch_underworld(body)
		body.queue_free()
