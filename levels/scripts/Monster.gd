extends Area2D

signal human_eated

var human_eated = 0

func _on_Finish_body_entered(body):
	human_eated += 1
	body.queue_free()
	emit_signal('human_eated', body)
