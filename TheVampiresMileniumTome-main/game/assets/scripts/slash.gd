extends Node2D

@onready var timer = $Timer
@onready var collision_shape_2d = $SlashHitBox/CollisionShape2D
@onready var animation = $AnimationPlayer

signal slashes

var cooldown = 0;


# Called when the node enters the scene tree for the first time.
func _ready():
	$"..".connect("slashes", _on_slashes)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if cooldown > 0:
		cooldown = cooldown - 1 * delta
		if cooldown < 0:
			cooldown = 0;
	pass

func _on_slashes():
	
	slash(get_global_mouse_position())

func slash(mousePosition : Vector2):
	if !cooldown:
		cooldown = 1
		var node_pos = global_position
		var direction = mousePosition - node_pos
		var angle = direction.angle()
		rotation = angle
		collision_shape_2d.set("disabled",false)
		animation.play("slash")
		timer.start(.5)
	
	
	
		
			


func _on_timer_timeout():
	
	collision_shape_2d.set("disabled",true)
	pass # Replace with function body.
