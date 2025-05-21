extends Area2D
@onready var timer = $Timer
@onready var diddler = $".."



func _on_body_entered(body):
	
	if body.has_method("isPlayer"):
		timer.start()
		print("IM GONNA MURDER YOU!!!!!!!!")
pass




func _on_timer_timeout():
	get_tree().reload_current_scene()


func _on_area_entered(area):
	print(area)
	diddler.health = diddler.health - 10
	print(diddler.health)
	
	pass # Replace with function body.
