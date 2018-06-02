extends Node2D


func _on_Lever_off():
	for child in get_children():
		child.activate()

func _on_Lever_on():
	for child in get_children():
		child.activate()
