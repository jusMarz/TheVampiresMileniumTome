extends Node2D

@onready var area_2d = $Area2D
@onready var player = $"."
@export var speed = 5
var angle =0
var shooting = true
signal shoots
@export var DAMAGE = 99
@export var STUN  = 0.00
@export var KNOCKBACK = 1
@onready var collisionbox = $collisionbox

# Called when the node enters the scene tree for the first time.

func _physics_process(delta):

	if shooting:
		print(angle)
		angle = get_angle_to_target_node()
		position.x += delta * 200 * cos(angle) * speed
		position.y += delta * 200 * sin(angle) * speed
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



func _on_area_2d_body_entered(body):
	var bodies = area_2d.get_overlapping_bodies()
	var count = 0
	var playerColide = false
	for things in bodies:
		print(things)
		if things.to_string().contains("Player"):
			print("hit player")
			playerColide = true
		if things.to_string().contains("TileMap"):
			print("delete ball")
			print(bodies.size())
			queue_free()
		if things.to_string().contains("diddler"):
			print("delete ball")
			print(bodies.size())
			queue_free()
	

func give_stats():
	var attack_stats = [DAMAGE,STUN,KNOCKBACK,"Good"] 
	return attack_stats


func _on_area_2d_area_entered(area):
	print("touched area")
	var areas = area_2d.get_overlapping_areas()
	for things in areas:
		print(things.get_parent())

