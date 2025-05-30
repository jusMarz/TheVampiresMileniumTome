extends Area2D
@onready var timer = $Timer
@onready var diddler = $".."



func _on_body_entered(body):
	
	if body.has_method("isPlayer"):
		timer.start()
		print("IM GONNA MURDER YOU!!!!!!!!")
pass




func _on_timer_timeout():
	#get_tree().reload_current_scene()


func _on_area_entered(area):
	var node = area.get_parent()
	print(node)
	if node.has_method("get_stats"):
		diddler.health = diddler.health - node.get_stats(0)
		diddler.stun_meter = diddler.stun_meter + node.get_stats(1)
		diddler.knockback = diddler.stun_meter + node.get_stats(2)
	
	pass # Replace with function body.
