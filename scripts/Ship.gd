extends KinematicBody2D

var target = Vector2()
var in_target = true
var lvel = Vector2()
var SPEED = 200

var active = false setget set_active
func set_active(value):
	active = value
	$Camera2D.current = value
	target = position

func _physics_process(delta):
	if active:
		if Input.is_action_just_pressed("attack"):
			target = get_global_mouse_position()
			in_target = false
		var tvel = Vector2()
		if not in_target:
			if global_position.distance_to(target) > SPEED * delta:
				tvel = (target - global_position).normalized() * SPEED
			else:
				in_target = true
		lvel = lerp(lvel, tvel, 0.5)
		lvel = move_and_slide(lvel)
		
		$AnimationTree.set("parameters/move/blend_position", Vector2(lvel.normalized()))
		
		if get_slide_count() > 0:
			lvel = Vector2()
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.collider.is_in_group("player"):
				collision.collider.take_damage(10)
