extends Node2D


func _ready() -> void:
	$VisibilityNotifier2D.connect("screen_exited", self, "queue_free")
