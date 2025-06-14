extends Area2D
@onready var timer = $Timer
@onready var parent = get_parent()
@export var ALIGNMENT: String


func _on_area_entered(area):
	#print (str(parent)+"this is the parent " + str(area))
	var attack = area.get_parent()
	if ((attack.has_method("give_stats"))):
		var stats = attack.give_stats()
		#print(stats)
		if ALIGNMENT == stats[3]:
			print("WORKS")
		else:
			#print(str(parent) + ": " + str(attack)+" up in my area")
			parent.health = parent.health - stats[0]
			parent.stun_meter = parent.stun_meter + stats[1]
			parent.knockback = parent.stun_meter + stats[2]
	pass # Replace with function body.


