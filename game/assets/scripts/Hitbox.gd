extends Area2D
@onready var timer = $Timer
@onready var diddler = $".."



func _on_body_entered(body):
	
	if body.has_method("isPlayer"):
		print("IM GONNA MURDER YOU!!!!!!!!")
pass
