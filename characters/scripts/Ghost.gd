extends KinematicBody2D

signal enter_body

enum states {IDLE, MOVE, ENTER_HOST, OUT_HOST}
var state

export (int) var speed = 200

var input_direction = Vector2()
var velocity = Vector2()

var available_host = null

var is_out = false

func _ready():
	_change_state(IDLE)
	
func _input(event):
	if is_out and event.is_action_pressed("power") and available_host != null:
		_change_state(ENTER_HOST)

func _change_state(new_state):
	match new_state:
		IDLE:
			$AnimatedSprite.animation = "idle"
			$AnimatedSprite.play()
		MOVE:
			# play move animation
			pass
		ENTER_HOST:
			enter_host()
		OUT_HOST:
			$AnimatedSprite.animation = "out"
			$AnimatedSprite.play()
			$Scream.play()

	state = new_state

func _physics_process(delta):
	update_direction()
	
	match state:
		IDLE:
			if input_direction:
				_change_state(MOVE)
		MOVE:
			if not input_direction:
				_change_state(IDLE)

	velocity = input_direction.normalized() * speed
	
	move_and_slide(velocity)

func update_direction():
	input_direction = Vector2()
	if(is_out):
		input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
		input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
		
		$AnimatedSprite.flip_h = input_direction.x < 0

func enter_host():
	is_out = false
	$AnimatedSprite.animation = "in"
	$AnimatedSprite.play()
	emit_signal("enter_body")
	$EnterBody.play()
	available_host.ghost_in()

func out(host):
	position = host.position
	position.y -= 28
	position.x -= 8
	show()
	_change_state(OUT_HOST)

func _on_Area2D_body_entered(host):
	if host.collision_layer == 1:
		available_host = host
	
func _on_Area2D_body_exited(host):
	available_host = null

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "out":
		is_out = true
		_change_state(IDLE)
	
	if $AnimatedSprite.animation == "in":
		visible = false
		_change_state(IDLE)