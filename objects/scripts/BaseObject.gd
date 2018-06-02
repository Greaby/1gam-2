extends Area2D

func activate():
	pass

func _on_BaseObject_area_entered(area):
	$Outline.show()

func _on_BaseObject_area_exited(area):
	$Outline.hide()
