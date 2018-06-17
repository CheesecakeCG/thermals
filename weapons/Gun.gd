extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var dmg = 5.0 #Damage per second

var is_shooting = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	 
	if is_shooting:
		rotation_degrees += Vector3(ease(randf(), 3), ease(randf(), 3), ease(randf(), 3)) * get_parent().spray
		if $RayCast.is_colliding():
			var col = $RayCast.get_collider()
			if col.is_in_group("player"):
				col.damage(dmg * delta)
				


func _on_CooldownTimer_timeout():
	$ActiveTimer.start()
	$CooldownTimer.stop()
	is_shooting = true
	$AnimationPlayer.play("fire")
	


func _on_ActiveTimer_timeout():
	$CooldownTimer.start()
	$ActiveTimer.stop()
	is_shooting = false
	

