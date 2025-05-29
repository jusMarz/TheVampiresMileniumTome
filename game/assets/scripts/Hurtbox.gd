extends Area2D
@onready var timer = $Timer
@onready var parent = get_parent()

func _on_area_entered(area):
	var node = area.get_parent()
	if ((node.has_method("get_stats")) && (!node.has_method("isPlayer"))):
		print(parent)
		print("someone up in my area")
		print(area)
		print(node)
		parent.health = parent.health - node.get_stats(0)
		parent.stun_meter = parent.stun_meter + node.get_stats(1)
		parent.knockback = parent.stun_meter + node.get_stats(2)
	pass # Replace with function body.


func _on_body_entered(body):
	print(parent)
	print("Ow! This guy touched me!:")
	print(body)
	pass # Replace with function body.
