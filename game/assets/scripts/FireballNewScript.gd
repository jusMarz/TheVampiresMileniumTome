extends Area2D

@onready var player = $"."
var speed = 10
var angle =0
var shooting = true
signal shoots
# Called when the node enters the scene tree for the first time.

func _physics_process(delta):
	print(shooting)
	if shooting:
		print(angle)
		angle = get_angle_to_target_node()
		shooting= false

	position.x += delta * 30 * cos(angle) * speed
	position.y += delta * 30 * sin(angle) * speed



func get_angle_to_target_node():
	return (atan2(( -player.position.y +  get_global_mouse_position().y),(-player.position.x + get_global_mouse_position().x)))


func _ready():
	$".".connect("shoots", _on_shoots)


func _on_shoots():
	print("ij3 vnturghnow4hrj qpejrtgaw")
	shooting = not shooting
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	var bodies = get_overlapping_bodies()
	var count = 0

	if bodies.size() != 1:
		print(bodies.size())
		queue_free()

	pass # Replace with function body.
