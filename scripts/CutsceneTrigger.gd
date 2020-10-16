extends Area2D


export var cutscene: String

func _ready() -> void:
	connect("body_entered", self, "on_body_entered")

func on_body_entered(body: Node):
	if body.is_in_group("player"):
		LevelManager.add_scene(cutscene)
		queue_free()
