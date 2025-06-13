extends Area2D

@export var spawn_object = preload("res://assets/scenes/diddler.tscn")
var entered = false
@onready var timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass# Replace with function body.
	add_child(timer)

func spawn():
	var obj = spawn_object.instantiate()
	var random = randi_range(1,4)
	if random == 1:
		obj.position = Vector2(200,-150)
	else: if random == 2:
		obj.position = Vector2(-150,150)
	else: if random == 3:
		obj.position = Vector2(-150,-150)
	else: if random == 4:
		obj.position = Vector2(200,125)
	get_tree().root.add_child(obj)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if(body.has_method("isPlayer")):
		print("enter")
		if(entered==false):
			spawn()
			entered = true
		while(entered):
			spawn()
			await get_tree().create_timer(1).timeout
	
 # Replace with function body.
