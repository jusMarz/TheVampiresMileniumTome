extends Node2D

"res://assets/music/slendytubbies - tinky winky scream-yt.savetube.me.mp3"
var target_node
var SPEED = 2
enum State {Idle,Aggresive}
@export var state : State
var AGGRO_MIN = 100;
var AGGRO_RANGE = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	target_node = get_owner().get_node("Player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var distance = sqrt(pow((target_node.position.y - position.y),2) + pow((target_node.position.x - position.x),2))
	if distance > AGGRO_MIN + AGGRO_RANGE:
		state = State.Idle
	if distance < AGGRO_MIN:
		state = State.Aggresive
		
	match state:
		State.Aggresive:
			var angle = (abs(atan2((-position.y + target_node.position.y),(-position.x + target_node.position.x))))
			position.x += ((-position.x + target_node.position.x)/abs(position.x - target_node.position.x)) * delta * 30 * abs(cos(angle)) * SPEED
			position.y += ((-position.y + target_node.position.y)/abs(position.y - target_node.position.y)) * delta * 30 * abs(sin(angle)) * SPEED
		State.Idle:
			print("I am idle")
		_:
			print("something fugged up :(")
