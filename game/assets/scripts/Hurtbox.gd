extends Area2D
@onready var timer = $Timer
@onready var parent = get_parent()
@export var ALIGNMENT: String

func _on_area_entered(area):
	var node = area.get_parent()
	if ((node.has_method("get_stats"))):
	
		print(str(parent) + ": " + str(area)+" up in my area")
		parent.health = parent.health - node.get_stats(0)
		parent.stun_meter = parent.stun_meter + node.get_stats(1)
		parent.knockback = parent.stun_meter + node.get_stats(2)
	pass # Replace with function body.


