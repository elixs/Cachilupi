extends KinematicBody2D


var linear_vel = Vector2()

var SPEED = 400
var GRAVITY = 800


onready var playback = $AnimationTree.get("parameters/playback")

func _physics_process(delta):
	

	linear_vel.y += GRAVITY * delta
	
	linear_vel = move_and_slide(linear_vel, Vector2.UP)
	
	var on_floor = is_on_floor()
	
	
	
	var target_vel = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		0)
#		Input.get_action_strength("down") - Input.get_action_strength("up"))
	
	linear_vel.x = lerp(linear_vel.x, target_vel.x * SPEED, 0.5)
	
	
	if on_floor and Input.is_action_just_pressed("jump"):
		linear_vel.y -= SPEED
	
	
	
	
	if linear_vel.length_squared() > 10:
		playback.travel("run")
	else:
		playback.travel("idle")
		
	if Input.is_action_just_pressed("attack"):
		playback.travel("attack")
	
	if target_vel.x < 0:
		$Sprite.flip_h = true
	if target_vel.x > 0:
		$Sprite.flip_h = false
	
	
