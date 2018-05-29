extends Area2D

signal on
signal off

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
			emit_signal("on")
			$AnimatedSprite.animation = "top"
		BOTTOM:
			emit_signal("off")
			$AnimatedSprite.animation = "bottom"
			
	$AnimatedSprite.play()

func activate():
	match state:
		TOP:
			_change_state(BOTTOM)
		BOTTOM:
			_change_state(TOP)
	

func _on_Lever_area_entered(area):
	$Outiline.show()
	
func _on_Lever_area_exited(area):
	$Outiline.hide()
