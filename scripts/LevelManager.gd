extends Node

onready var Game = get_tree().get_root().get_node("Game")

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
