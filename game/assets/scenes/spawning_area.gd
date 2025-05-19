extends Area2D

@export var spawn_object = preload("res://assets/scenes/diddler.tscn")
var entered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass# Replace with function body.

func spawn():
	var obj = spawn_object.instance()
	obj.position = position
	obj.translation = Vector2(-200,125)
	get_parent().get_node("diddler").add_child(obj)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_body_entered(body):
	if(entered==false):
		spawn()
	entered = true # Replace with function body.
