extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Hero.active = true


func _input(event):
	var just_pressed = event.is_pressed() and not event.is_echo()
	if event.is_action_pressed("swap") and just_pressed:
		$Hero.active = !$Hero.active
		$Spider.active = !$Spider.active
