extends Node2D

@export var slashing = false
@onready var animation = $AnimationPlayer
signal slashes


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_slashes():
	print("efjwqewf")
	slash(get_global_mouse_position())

func slash(mousePosition : Vector2):
	transform.translated_local(mousePosition)
	transform.rotated_local(get_angle_to(mousePosition))
	slashing = true
	animation.play("slash")
	var overlapping_objects = $SlashHitBox.get_overlapping_areas()
	
	for area in overlapping_objects:
		var parent = area.get_parent()
		print(parent.name)
			
