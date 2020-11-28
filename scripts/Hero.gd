extends KinematicBody2D


var linear_vel = Vector2()

var SPEED = 200
var SPEED_SQUARED = SPEED * SPEED
var GRAVITY = 400

var invincible = false

var health = 100 setget set_health
func set_health(value):
	health = clamp(value, 0, 100)
	$CanvasLayer/Health.value = health
	if health == 0:
		self.lives -= 1
		health = 100

var lives = 3 setget set_lives
func set_lives(value):
	if value < lives:
		LevelManager.go_to_checkpoint(self)
	if value < 0:
		LevelManager.reset()
	lives = clamp(value, 0, 3)
	 
	for i in $PauseMenu/HBoxContainer.get_child_count():
		if i < lives:
			$PauseMenu/HBoxContainer.get_child(i).show()
		else:
			$PauseMenu/HBoxContainer.get_child(i).hide()

var mana = 100 setget set_mana
func set_mana(value):
	mana = clamp(value, 0, 100)
	$CanvasLayer/Mana.value = mana

var facing_right = true

var active = false setget set_active
func set_active(value):
	active = value
	$Camera2D.current = value


var Bullet = preload("res://scenes/Bullet.tscn")


onready var playback = $AnimationTree.get("parameters/playback")


func _ready() -> void:
	$InvincibilityTimer.connect("timeout", self, "on_InvincibilityTimer_timeout")
	$PauseMenu/VBoxContainer/Continue.connect("pressed", self, "on_Continue_pressed")
	$PauseMenu/VBoxContainer/Exit.connect("pressed", self, "on_Exit_pressed")
	LevelManager.start_position = global_position

func _physics_process(delta):
	
	linear_vel.y += GRAVITY * delta
	
	linear_vel = move_and_slide(linear_vel, Vector2.UP)
	
	var on_floor = is_on_floor()
	
	var target_vel = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		0)
#		Input.get_action_strength("down") - Input.get_action_strength("up"))
	
	if not active:
		target_vel = Vector2()
	
	linear_vel.x = lerp(linear_vel.x, target_vel.x * SPEED, 0.5)
	
	
	if on_floor and Input.is_action_just_pressed("jump") and active:
		linear_vel.y -= SPEED
	
	
	var attacking = Input.is_action_just_pressed("attack") and active
	
	if Input.is_action_just_pressed("pause"):
		$PauseMenu/VBoxContainer.show()
		get_tree().paused = true

	# Animation
	
	if on_floor:
		if linear_vel.length_squared() > 10:
			playback.travel("run")
			$AnimationTree.set("parameters/run/TimeScale/scale", 0.5 + linear_vel.length_squared() / SPEED_SQUARED / 2.0)
		else:
			playback.travel("idle")
	else:
		if linear_vel.y > 0:
			playback.travel("fall")
		elif linear_vel.y < 0:
			playback.travel("jump")
	if attacking:
		playback.travel("attack")
	
	if facing_right and target_vel.x < 0:
		scale.x = -1
		facing_right = false
		
	if not facing_right and target_vel.x > 0:
		scale.x = -1
		facing_right = true

func fire():
	var bullet = Bullet.instance()
	get_parent().add_child(bullet)
	bullet.rotation = 0 if facing_right else PI
	bullet.global_position = $Bullet.global_position
	self.mana -= 10

func take_damage(value):
	if not invincible:
		self.health -= value
		$InvincibilityTimer.start()
		modulate.a = 0.5
	invincible = true

func on_InvincibilityTimer_timeout():
	modulate.a = 1
	invincible = false
	
# Pause Menu

func on_Continue_pressed():
	$PauseMenu/VBoxContainer.hide()
	get_tree().paused = false
	

func on_Exit_pressed():
	get_tree().paused = false
	LevelManager.reset()

func teleport(new_position: Vector2):
	global_position = new_position
	if not facing_right:
		scale.x = -1
		facing_right = true
