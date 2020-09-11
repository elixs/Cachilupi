extends KinematicBody2D


var linear_vel = Vector2()


onready var playback = $AnimationTree.get("parameters/playback")

func _physics_process(delta):
	var target_vel = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	linear_vel.x = lerp(linear_vel.x, target_vel * 400, 0.5)
	
	linear_vel = move_and_slide(linear_vel)
	
	if linear_vel.length_squared() > 10:
		playback.travel("run")
	else:
		playback.travel("idle")
	
	if target_vel < 0:
		$Sprite.flip_h = true
	if target_vel > 0:
		$Sprite.flip_h = false
	
	
