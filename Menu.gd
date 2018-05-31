extends Control

signal resume
signal retry
signal quit

func _on_ResumButton_pressed():
	emit_signal("resume")

func _on_RetryButton_pressed():
	emit_signal("retry")

func _on_QuitButton_pressed():
	emit_signal("quit")
