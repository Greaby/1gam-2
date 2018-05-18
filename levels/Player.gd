extends KinematicBody2D

signal die

export (int) var speed = 200
export (int) var jump_speed = 600
export (int) var gravity = 20

export (bool) var is_possessed = false

export (int) var life_number = 1

var velocity = Vector2()

func _physics_process(delta):
	velocity.x = 0
	
	if(is_possessed):
		velocity.x = (int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))) * speed
		
		if is_on_floor() and Input.is_action_pressed("jump"):
			velocity.y = -jump_speed
			
		if Input.is_action_just_pressed("power"):
			_die()
		
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
func _die():
	$AnimatedSprite.animation = "out"
	$AnimatedSprite.play()
	is_possessed = false
	life_number -= 1
	emit_signal("die")
	