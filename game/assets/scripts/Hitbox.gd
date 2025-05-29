extends Area2D

@onready var diddler = $".."

func _on_body_entered(body):
	print (body)
	if body.has_method("isPlayer"):
		print("getting frewaky")
pass
