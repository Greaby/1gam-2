extends "BaseObject.gd"

enum states {TOP, BOTTOM}
export (states) var state = TOP

func _ready():
	match state:
		TOP:
			$AnimatedSprite.animation = "top"
		BOTTOM:
			$AnimatedSprite.animation = "bottom"
			
	$AnimatedSprite.frame = $AnimatedSprite.frames.get_frame_count($AnimatedSprite.animation) - 1

func _change_state(new_state):
	state = new_state
	
	match state:
		TOP:
			$AnimatedSprite.animation = "top"
		BOTTOM:
			$AnimatedSprite.animation = "bottom"
			
	$AnimatedSprite.play()

func activate():
	match state:
		TOP:
			_change_state(BOTTOM)
		BOTTOM:
			_change_state(TOP)
