extends Node2D

#enemy stats

@onready var audio_stream_player_2d = $AnimatedSprite2D/AudioStreamPlayer2D
@onready var player = %Player

@export var health = 100
var SPEED = 2
enum State {Idle,Aggresive,Stunned}
var stun_meter = 0;
@export var state : State
var AGGRO_MIN = 100;
var AGGRO_RANGE = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#Used to get the angle to the player
#But abs
#So like for 270 degrees it will give you pi/2 due to the abs so you'll still need the direction of the target node
func get_angle_to_target_node():
	return (abs(atan2((-position.y + player.position.y),(-position.x + player.position.x))))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var distance = sqrt(pow((player.position.y - position.y),2) + pow((player.position.x - position.x),2))
	if distance > AGGRO_MIN + AGGRO_RANGE:
		state = State.Idle
	if distance < AGGRO_MIN:
		state = State.Aggresive
	if stun_meter:
		state = State.Stunned
		
	match state:
		State.Aggresive:
			if audio_stream_player_2d.playing:
				audio_stream_player_2d.play()
			var angle = get_angle_to_target_node()
			position.x += (int(position.x < player.position.x) - int(position.x > player.position.x)) * delta * 30 * abs(cos(angle)) * SPEED
			position.y += (int(position.y < player.position.y) - int(position.y > player.position.y)) * delta * 30 * abs(sin(angle)) * SPEED
		State.Idle:
			audio_stream_player_2d.stop()
		State.Stunned:
			stun_meter -= 1 * delta
			if stun_meter < 0:
				stun_meter = 0;
		_:
			pass
