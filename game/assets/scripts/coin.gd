extends Area2D
@onready var player = %Player
@onready var audio_stream_player_2d = $AudioStreamPlayer2D

enum State {Idle,Aggresive}
@export var state : State
var target_node
var SPEED = 10;

func _process(delta):
	var distance = sqrt(pow((player.position.y - position.y),2) + pow((player.position.x - position.x),2))
	if distance < 50:
		state = State.Aggresive
		
	match state:
		State.Aggresive:
			var angle = (abs(atan2((-position.y + player.position.y),(-position.x + player.position.x))))
			position.x += ((-position.x + player.position.x)/abs(position.x - player.position.x)) * delta * 30 * abs(cos(angle)) * SPEED
			position.y += ((-position.y + player.position.y)/abs(position.y - player.position.y)) * delta * 30 * abs(sin(angle)) * SPEED
			audio_stream_player_2d.play()
	

func _on_body_entered(body):
	print("got coin")
	queue_free()
