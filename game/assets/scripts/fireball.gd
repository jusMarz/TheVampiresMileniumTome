extends Node2D
@onready var player = $".."
@onready var timer = $Timer
@onready var animated_sprite = $AnimatedSprite2D
@onready var collision = $FireBallHitBox/CollisionShape2D
@onready var mousePos = Vector2(0,0)

var object_scene = preload("res://assets/scenes/fireball.tscn")

var SPEED = 10
var angle =0
var shooting = false
signal shoots
signal spawnBall
# Called when the node enters the scene tree for the first time.\


func _ready():
	$"..".connect("shoots", _on_shoots)
	
	
	
func get_angle_to_target_node():

	return (atan2(( -player.position.y +  get_global_mouse_position().y),(-player.position.x + get_global_mouse_position().x)))


func spawn_object(position):
	print("object spawned")
	var new_fireball = object_scene.instantiate()
	new_fireball.position = position
	get_tree().root.add_child(new_fireball)

func _on_shoots():
	timer.start(3)
	print("timer start")
	shooting = true
	mousePos = get_global_mouse_position()
	angle = get_angle_to_target_node()
	visible = true
	collision.disabled = false
	print(angle)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shooting:
		position.x += delta * 30 * cos(angle) * SPEED
		position.y += delta * 30 * sin(angle) * SPEED


func _on_timer_timeout():
	emit_signal("spawnBall")


func _on_fireball_tree_entered():
	print("start")
	pass # Replace with function body.


func _on_child_entered_tree(node):
	print("child has entered the tree")
