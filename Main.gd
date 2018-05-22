extends Node2D

var levels = []
var current_level

func _ready():
	levels.append("res://levels/Level1.tscn")
	levels.append("res://levels/Level2.tscn")
	levels.append("res://levels/Level3.tscn")

	_load_next_level()


func _load_next_level():
	if levels.size() > 0:
		for child in $Level.get_children():
			child.queue_free()
		
		var scene = load(levels.pop_front())
		var current_level = scene.instance()
		
		$Level.add_child(current_level)
		
		current_level.connect("switch_underworld", self, "_play_underworld_background")
		current_level.connect("switch_world", self, "_play_world_background")		
		current_level.connect("level_complete", self, "_load_next_level")
		
func _play_underworld_background():
	$AnimationPlayer.play("underworld")
	
func _play_world_background():
	$AnimationPlayer.play("world")