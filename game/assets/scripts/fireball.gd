extends Node2D
@onready var player = $".."
@onready var timer = $Timer
@onready var animated_sprite = $AnimatedSprite2D
@onready var collision = $FireBallHitBox/CollisionShape2D
@onready var mouse_pos = Vector2(0,0)

var object_scene = preload("res://assets/scenes/fireball.tscn")

var SPEED = 10
var angle =0
var shooting = false
signal shoots

# Called when the node enters the scene tree for the first time.\


func _ready():
	$"..".connect("shoots", _on_shoots)
	print("started fireball")

	
	
	
func get_angle_to_target_node():

	return (atan2(( -player.position.y +  get_global_mouse_position().y),(-player.position.x + get_global_mouse_position().x)))



func _on_shoots():
	print("shoot signal recieved")
	shooting = true
	mouse_pos = get_global_mouse_position()
	angle = get_angle_to_target_node()
	#visible = true
	#collision.disabled = false
	print(angle)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shooting:
		visible=true
		animated_sprite.play("fireball")
		position.x += delta * 30 * cos(angle) * SPEED
		position.y += delta * 30 * sin(angle) * SPEED




func _on_fireball_tree_entered():
	print("start")
	pass # Replace with function body.


func _on_child_entered_tree(node):
	print("child has entered the tree")
