extends KinematicBody2D

export (Vector2) var top = Vector2()
export (Vector2) var bottom = Vector2()

enum states {TOP, BOTTOM}
export (states) var state = TOP

func _ready():
	if(state == TOP):
		position = top
	else:
		position = bottom

func _change_state(new_state):
	state = new_state
	
	#$Tween.stop($".", "transform/position")
	
	match state:
		TOP:
			$Tween.interpolate_property($".", "transform/origin", position, top, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		BOTTOM:
			$Tween.interpolate_property($".", "transform/origin", position, bottom, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			
	$Tween.start()

func activate():
	print(state)
	match state:
		TOP:
			_change_state(BOTTOM)
		BOTTOM:
			_change_state(TOP)