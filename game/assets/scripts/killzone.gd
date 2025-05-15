extends Area2D
@onready var timer = $Timer



func _on_body_entered(body):
	if body.has_method("isPlayer"):
		timer.start()
		print("IM GONNA DIDDLE YOU!!!!!!!!")
	
	
	
	pass




func _on_timer_timeout():
	get_tree().reload_current_scene()
