extends "res://entities/Entity.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var _center = get_viewport().size/2
onready var _og_camTarg_rot = $CamTarg.rotation_degrees
onready var gui_health_bar = $HUD/VBoxContainer/HealthBar
onready var gui_temp_bar = $HUD/VBoxContainer/TempBar

var temp = 40


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	hp = 2000
	gui_health_bar.max_value = max_hp
	_updateHP()
	_updateTemp()
	pass
func _process(delta):
	if is_on_floor():
		stop_y(delta)

func _alive_process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	var dir = get_viewport().get_mouse_position()
	dir = dir.angle_to_point(_center) + deg2rad(-90) 
	
	rotation.y = -dir 
	
	$CamTarg.rotation_degrees = -rotation_degrees + _og_camTarg_rot
	
	
	if Input.is_action_pressed("player_backwards"):
		vel.z -= move_speed * delta
		heat_up(move_speed * delta * .1)
	else:
		if Input.is_action_pressed("player_forwards"):
			vel.z += move_speed * delta
			heat_up(move_speed * delta * .1)
		else:
			stop_z(delta)

	if Input.is_action_pressed("player_right"):
		vel.x -= move_speed * delta
		heat_up(move_speed * delta * .1)
	else:
		if Input.is_action_pressed("player_left"):
			vel.x += move_speed * delta
			heat_up(move_speed * delta * .1)
		else:
			stop_x(delta)
	if Input.is_action_just_pressed("cheat_reset_loc"):
		translation = Vector3()
	
	if Input.is_action_just_pressed("player_attack_primary"):
		
		if $PrimaryAttackCooldown.is_stopped():
			$PrimaryAttackCooldown.start()
			heat_up(5)
			for b in $Attack.get_overlapping_bodies():
				if b.is_in_group("enemies"):
					b.damage(abs(temp - 110))
					heat_up(10)
					print("Attacked: ", abs(temp - 110), " HP: ", b.hp)
	
	if temp > 80:
		damage(ease(temp, 2))
		if temp > 110:
			hp = 0
			_updateHP()
	
	temp -= abs(temp - 40) * delta
	_updateTemp()

func _updateHP():
	gui_health_bar.value = hp

func _updateTemp():
	gui_temp_bar.value = temp
	
func heat_up(dmg):
	temp += dmg
	_updateTemp()

func _on_Attack_body_entered(body):
	if Input.is_action_just_pressed("player_attack_primary"):
		if $PrimaryAttackCooldown.time_left <= 0:
			body
