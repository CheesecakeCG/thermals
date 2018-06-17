extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var ents = [preload("res://entities/Enemy/Wave1/mob.tscn"), 
			preload("res://entities/Enemy/Wave2/mob.tscn")]

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func spawn_ent(id):
	add_child(ents[id].instance())
