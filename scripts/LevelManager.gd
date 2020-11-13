extends Node

onready var Game = get_tree().get_root().get_node("Game")

var start_position: Vector2

var checkpoint: Node setget set_checkpoint
func set_checkpoint(value):
	if checkpoint:
		checkpoint.off()
	checkpoint = value
	checkpoint.on()

func go_to_checkpoint(node: Node2D):
	var new_position 
	if checkpoint:
		new_position = checkpoint.get_spawn_point()
	elif start_position:
		new_position = start_position
	if new_position:
		node.teleport(new_position)

func next():
	Game.next()  

func change_scene(scene):
	Game.change_scene(scene)

func reset():
	Game.reset()

func add_scene(scene):
	Game.add_scene(scene)

func remove_scene(scene_node):
	Game.remove_scene(scene_node)
