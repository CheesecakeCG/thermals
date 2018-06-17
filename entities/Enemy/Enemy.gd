extends "res://entities/Entity.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var nav = $"../../Navigation"
onready var player = $"../../Player"

var path

export var attack_dist = 20
export var spray = .1

var stay = false
#var _gotofloor = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	#_on_NavRefreshTimer_timeout()
	randomize()
#	vel = Vector3(randi() % 8, 0, randi() % 8)
	
	pass

#func _process(delta):
#	vel.y = 0
#	translation.y = 0

func _alive_process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if translation.distance_to(player.translation) >= attack_dist and stay == false:
		follow_path_to_player(delta)
	else:
		stay = true
		stop(delta)
		attack(delta)
	
	if translation.distance_to(player.translation) <= attack_dist * 2:
		stay = false
	look_at(player.translation, Vector3(0, 1, 0))
	## TODO
	# When enemy is within an exported distance, and has direct line of size, shoot
	# Add a spawner that starts and stops waves.

func _dead_process(delta):
	queue_free()

func follow_path_to_player(delta):
	#$Gun.hide()
	if not path == null:
		if path.size() > 0:
			path[0].y = 0
			vel -= (translation - path[0]) * delta * move_speed
			if translation.distance_to(path[0]) < 3:
				path.remove(0)
				stop(delta)

func attack(delta):
	#$Gun.show()
	pass

func retreat(delta):
	pass
	


func _on_NavRefreshTimer_timeout():
	path = nav.get_simple_path(translation, player.translation, true)
	
	$NavRefreshTimer.start()
