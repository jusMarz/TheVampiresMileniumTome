extends MultiplayerSpawner

signal spawnBall
@onready var player = $".."
# Called when the node enters the scene tree for the first time.
func _ready():
	add_spawnable_scene("res://assets/scenes/fireball.tscn")
	$"../fireball".connect("spawnBall",_on_spawnBall)


func _on_spawnBall():
	
	var fireball = load("res://assets/scenes/fireball.tscn").instantiate()
	# Set the position and other properties for the fireball
	fireball.position = player.position# example
	# Add the fireball as a child of the spawner's spawn path
	# This will automatically replicate it to all clients
	add_child(fireball)
	set_owner(get_owner())
	# Optionally, set a spawn limit if needed
	# MySpawner.set_spawn_limit(10) # example
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
