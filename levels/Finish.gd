extends Area2D


signal level_complete

func _on_Finish_body_entered(body):
	print("level complete")
	emit_signal('level_complete')
