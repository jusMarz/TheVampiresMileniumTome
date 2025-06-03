extends Node2D
@onready var timer = $Timer

#enemy stats

@onready var audio_stream_player_2d = $AnimatedSprite2D/AudioStreamPlayer2D
@onready var player = get_node("/root/Game/Player")

@export var health = 100
@export var SPEED = 80
enum State {Idle,Aggresive,Stunned,Dead,Attacking}
var stun_meter = 0;
var knockback = 0;
@export var state : State
@export var AGGRO_MIN = 100;
@export var AGGRO_RANGE = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#Used to get the angle to the player
func getangleto(thing):
	return (atan2((-position.y + thing.position.y),(-position.x + thing.position.x)))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var distance = sqrt(pow((player.position.y - position.y),2) + pow((player.position.x - position.x),2))
	var angle = getangleto(player)
	if health <= 0:
		state = State.Dead
	else:
		if knockback < 0:
			knockback = 0
		if knockback:
			position.x += delta * 30 * -(cos(angle)) * knockback
			position.y += delta * 30 * -(sin(angle)) * knockback
			knockback = knockback - 30 * delta
		if stun_meter:
			state = State.Stunned
		else: 
			if distance > AGGRO_MIN + AGGRO_RANGE:
				state = State.Idle
			else: if distance < AGGRO_MIN:
				if distance < 35:
					state = State.Attacking
					$AnimationPlayer.play("attack")
				else:
					$AnimationPlayer.queue("chasing")
					state = State.Aggresive
	
		
	match state:
		State.Dead:
			if timer.is_stopped():
				print("timer start")
				timer.start()
		State.Aggresive:
			if audio_stream_player_2d.playing:
				audio_stream_player_2d.play()
			position.x += delta * (cos(angle)) * SPEED
			position.y += delta * (sin(angle)) * SPEED
		State.Idle:
			audio_stream_player_2d.stop()
		State.Stunned:
			stun_meter -= 1 * delta
			if stun_meter < 0:
				stun_meter = 0;
		_:
			pass


func _on_timer_timeout():
	print("HEY")
	queue_free()
	pass # Replace with function body.
