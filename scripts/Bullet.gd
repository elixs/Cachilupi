extends Area2D

var SPEED = 600

func _ready():
	$VisibilityNotifier2D.connect("screen_exited", self, "queue_free")

func _physics_process(delta):
	
	position += Vector2(cos(rotation), sin(rotation)) * SPEED * delta

