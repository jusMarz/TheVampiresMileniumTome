extends Node2D
@onready var timer = $Timer

#enemy stats

@onready var audio_stream_player_2d = $AnimatedSprite2D/AudioStreamPlayer2D
@onready var player = %Player

@export var health = 100
var SPEED = 2
enum State {Idle,Aggresive,Stunned,Dead}
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
	if health < 100:
		state = State.Dead
	else: if stun_meter:
		state = State.Stunned
	else: 
		var distance = sqrt(pow((player.position.y - position.y),2) + pow((player.position.x - position.x),2))
		if distance > AGGRO_MIN + AGGRO_RANGE:
			state = State.Idle
		else: if distance < AGGRO_MIN:
			state = State.Aggresive
	
		
	match state:
		State.Dead:
			print("uh oh")
			timer.start(2)
		State.Aggresive:
			health = health - (5 *delta)
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


func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.
