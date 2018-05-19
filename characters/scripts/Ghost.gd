extends KinematicBody2D

signal enter_body

export (int) var speed = 200

var input_direction = Vector2()
var velocity = Vector2()

var available_host = null

var is_out = false

func _physics_process(delta):
	if(is_out):
		input_direction = Vector2()
	
		input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
		input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
		
		velocity = input_direction.normalized() * speed
		
		move_and_slide(velocity)
		
		if available_host != null and Input.is_action_just_pressed("power"):
			enter(available_host)

func enter(host):
	host.is_possessed = true
	is_out = false
	visible = false
	$AnimatedSprite.stop()
	emit_signal("enter_body")
	$EnterBody.play()
			
func out(host):
	position = host.position
	position.y -= 28
	position.x -= 8
	show()
	$AnimatedSprite.animation = "out"
	$AnimatedSprite.play()
	$Scream.play()

func _on_Area2D_body_entered(host):
	available_host = host
	
func _on_Area2D_body_exited(host):
	available_host = null


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation != "idle":
		is_out = true
		$AnimatedSprite.animation = "idle"
		$AnimatedSprite.play()
