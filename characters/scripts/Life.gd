extends Node2D

func lost():
	$Timer.start()

func _on_AnimatedSprite_animation_finished():
	queue_free()

func _on_Timer_timeout():
	$AnimatedSprite.animation = "break"
	$AnimatedSprite.play()
	$BreakSound.play()
