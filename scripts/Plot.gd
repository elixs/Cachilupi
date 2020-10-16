extends Node2D




func _process(delta: float) -> void:
	$CanvasLayer/VBoxContainer/RichTextLabel.percent_visible = 1 - $Timer.time_left / $Timer.wait_time
	
	if Input.is_action_just_pressed("attack"):
		$Timer.stop()
		on_timeout()


func _ready() -> void:
	$Timer.connect("timeout", self, "on_timeout")


func on_timeout():
	LevelManager.next()
