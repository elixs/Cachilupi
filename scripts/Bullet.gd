extends Area2D

func _ready():
	$VisibilityNotifier2D.connect("screen_exited", self, "queue_free")

func _physics_process(delta):
	position.x += 10

