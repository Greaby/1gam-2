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
	
	$Tween.stop($".", "position")
	
	match state:
		TOP:
			var total_move = bottom.y - top.y
			var move_left = position.y - top.y
			$Tween.interpolate_property($".", "position", position, top, move_left / total_move, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		BOTTOM:
			var total_move = bottom.y - top.y
			var move_left = total_move - (position.y - top.y)
			$Tween.interpolate_property($".", "position", position, bottom, move_left / total_move, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			
	$Tween.start()

func activate():
	print(state)
	match state:
		TOP:
			_change_state(BOTTOM)
		BOTTOM:
			_change_state(TOP)