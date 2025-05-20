extends Node2D

@export var slashing = false
@onready var animation = $AnimationPlayer
signal slashes


# Called when the node enters the scene tree for the first time.
func _ready():
	$"..".connect("slashes", _on_slashes)
	print("Start connection")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_slashes():
	print("efjwqewf")
	slash(get_global_mouse_position())

func slash(mousePosition : Vector2):
	var node_pos = global_position
	var direction = mousePosition - node_pos
	var angle = direction.angle()


	rotation = angle

	print(angle)
	#$".".rotate(get_angle_to(mousePosition))
	#$".".translate(mousePosition)
	slashing = true
	animation.play("slash")
	var overlapping_objects = $SlashHitBox.get_overlapping_areas()
	
	for area in overlapping_objects:
		var parent = area.get_parent()
		print(parent.name)
			
