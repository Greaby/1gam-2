extends KinematicBody2D

signal ghost_out

enum states {IDLE, WALK, JUMP, FALL, OUT_LOAD, GHOST_OUT, GHOST_IN}
var state



export (int) var speed = 200
export (int) var jump_speed = 400

const MAX_GRAVITY = 400
export (int) var gravity = 20
var gravity_enable = true

export (bool) var is_possessed = false

var input_direction = Vector2()
var velocity = Vector2()

var available_object = null



func _ready():
	_change_state(IDLE)
	
func _input(event):
	if not is_possessed:
		return
	
	if event.is_action_pressed("jump") and state in [IDLE, WALK]:
		return _change_state(JUMP)
	
	if is_possessed and event.is_action_pressed("power") and available_object != null:
		return available_object.activate()
		
	if is_possessed and event.is_action_pressed("power"):
		return _change_state(GHOST_OUT)
	
func _change_state(new_state):
	match new_state:
		IDLE:
			$AnimatedSprite.animation = "idle"
			$AnimatedSprite.play()
		WALK:
			$AnimatedSprite.animation = "walk"
			$AnimatedSprite.play()
		JUMP:
			$AnimatedSprite.animation = "jump"
			$AnimatedSprite.play()
			velocity.y = -jump_speed
		FALL:
			$AnimatedSprite.animation = "idle"
			$AnimatedSprite.play()
		GHOST_OUT:
			_ghost_out()
		GHOST_IN:
			$AnimatedSprite.animation = "in"
			$AnimatedSprite.play()
			
	state = new_state
	

func _physics_process(delta):
	update_direction()
	apply_gravity()
	
	match state:
		IDLE:
			if input_direction.x:
				_change_state(WALK)
		WALK:
			if not input_direction.x:
				_change_state(IDLE)
		JUMP:
			if velocity.y >= 0:
				_change_state(FALL)
		FALL:
			if is_on_floor():
				_change_state(IDLE)
	
	move()
	
func update_direction():
	input_direction = Vector2()
	
	if(is_possessed):
		input_direction.x = (int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")))

	$AnimatedSprite.flip_h = input_direction.x < 0
	
func apply_gravity():
	velocity.y += gravity
	if velocity.y >= MAX_GRAVITY:
		velocity.y = MAX_GRAVITY
		
	if not gravity_enable:
		velocity.y = 0
	
func move():
	velocity.x = input_direction.x * speed
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
func _ghost_out():
	$AnimatedSprite.animation = "out"
	$AnimatedSprite.play()
	is_possessed = false
	gravity_enable = false
	
	if has_node("Lives"):
		if $Lives.get_children().size() > 0:
			var life = $Lives.get_children().pop_back()
			life.lost()
		else:
			$AnimatedSprite.animation = "die"
			$AnimatedSprite.play()
	
	emit_signal("ghost_out")
	
func ghost_in():
	_change_state(GHOST_IN)
	

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "out":
		_change_state(IDLE)
		gravity_enable = true
		
	if $AnimatedSprite.animation == "in":
		_change_state(IDLE)
		is_possessed = true
		
	if $AnimatedSprite.animation == "die":
		queue_free()

func _on_ObjectDetection_area_entered(area):
	available_object = area

func _on_ObjectDetection_area_exited(area):
	available_object = null
