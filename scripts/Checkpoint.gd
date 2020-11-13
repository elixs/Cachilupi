extends Area2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", self, "on_body_entered")

func on_body_entered(body: Node):
	if body.is_in_group("player"):
		LevelManager.checkpoint = self

func on():
	$CollisionShape2D.set_deferred("disabled", true)
	print("%s is on" % name)

func off():
	$CollisionShape2D.set_deferred("disabled", false)
	print("%s is off" % name)

func get_spawn_point():
	return $Spawn.global_position
