extends Area2D




func _on_body_entered(body):
	print("got coin")
	queue_free()
