extends KinematicBody2D

signal enter_body

export (int) var speed = 200

var input_direction = Vector2()
var velocity = Vector2()

var contact = null

func _physics_process(delta):
	if(is_visible_in_tree()):
		input_direction = Vector2()
	
		input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
		input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
		
		velocity = input_direction.normalized() * speed
		
		move_and_slide(velocity)
		
		if contact != null and Input.is_action_just_pressed("power"):
			contact.is_possessed = true
			$".".visible = false
			emit_signal("enter_body")
			

func _on_Area2D_body_entered(body):
	contact = body
	
func _on_Area2D_body_exited(body):
	contact = null
