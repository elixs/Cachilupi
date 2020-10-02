extends Area2D

var SPEED = 600

func _ready():
	$VisibilityNotifier2D.connect("screen_exited", self, "queue_free")
	connect("body_entered", self, "on_body_entered")

func on_body_entered(body: Node):
	if body.is_in_group("enemy"):
		body.queue_free()

func _physics_process(delta):
	
	position += Vector2(cos(rotation), sin(rotation)) * SPEED * delta

