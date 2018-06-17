extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var vel = Vector3()
export var fric = 3
export var move_speed = 200
export var max_speed = 100
export var max_hp = 100
export var weight = 5

var hp = 100

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	hp = max_hp
	#_updateHP()
	
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	
	
	vel.x = clamp(vel.x, -max_speed, max_speed)
	vel.y = clamp(vel.y, -max_speed, max_speed)
	vel.z = clamp(vel.z, -max_speed, max_speed)
	
	vel -= move_and_slide(vel.rotated(transform.basis.y, rotation.y), Vector3(0,1,0) ).rotated(transform.basis.y, -rotation.y) / fric * delta
	
	if hp > 0:
		_alive_process(delta)
	else:
		_dead_process(delta)
	
func _alive_process(delta):
	pass

func _dead_process(delta):
	stop(delta)

func stop(delta):
	stop_z(delta)
	stop_x(delta)
	
func stop_x(delta):
	vel.x -= (fric * delta * vel.x)

func stop_y(delta):
	vel.y -=  delta * 9.81 * weight

func stop_z(delta):
	vel.z -= (fric * delta * vel.z)

func damage(dmg):
	hp -= dmg
	hp = min(hp, max_hp)
	_updateHP()
	
func _updateHP():
	
	pass