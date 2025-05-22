extends Node2D
@onready var player = $".."
@onready var timer = $Timer
@onready var animated_sprite = $AnimatedSprite2D
@onready var collision = $FireBallHitBox/CollisionShape2D
@onready var mousePos = Vector2(0,0)
var SPEED = 10
var angle =0
var shooting = false
signal shoots
# Called when the node enters the scene tree for the first time.\


func _ready():
	$"..".connect("shoots", _on_shoots)
	
	
func get_angle_to_target_node():

	return (atan2(( -player.position.y +  get_global_mouse_position().y),(-player.position.x + get_global_mouse_position().x)))
	
	
	
func _on_shoots():
	shooting = true
	mousePos = get_global_mouse_position()
	angle = get_angle_to_target_node()
	visible=true
	collision.disabled = false
	print(angle)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shooting:
		position.x += delta * 30 * cos(angle) * SPEED
		position.y += delta * 30 * sin(angle) * SPEED


	
	
	
	
