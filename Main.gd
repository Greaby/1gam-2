extends Node

var levels = []
var current_scene
var current_level

func _ready():
	levels.append("res://levels/Level1.tscn")
	levels.append("res://levels/Level2.tscn")
	levels.append("res://levels/Level3.tscn")

	_load_next_level()
	
func _process(delta):
	if Input.is_action_just_pressed("menu"):
		if $Menu.visible:
			hide_menu()
		else:
			show_menu()


func _load_next_level():
	if levels.size() > 0:
		for child in $Level.get_children():
			child.queue_free()
		
		current_scene = load(levels.pop_front())
		_load_level(current_scene)
		
func _load_level(scene):
	var current_level = scene.instance()
		
	$Level.add_child(current_level)
	
	current_level.connect("switch_underworld", self, "_play_underworld_background")
	current_level.connect("switch_world", self, "_play_world_background")
	current_level.connect("level_complete", self, "_load_next_level")
		
func _play_underworld_background():
	$AnimationPlayer.play("underworld")
	
func _play_world_background():
	$AnimationPlayer.play("world")

func _on_Menu_resume():
	hide_menu()

func _on_Menu_quit():
	get_tree().quit()

func _on_Menu_retry():
	_load_level(current_scene)
	hide_menu()
	
func show_menu():
	$Menu.visible = true
	$Level.get_tree().paused = true
	
func hide_menu():
	$Menu.visible = false
	$Level.get_tree().paused = false
