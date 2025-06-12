extends Node2D
@onready var timer = $Timer

#enemy stats

@onready var animation_player = $AnimationPlayer
@onready var audio_stream_player_2d = $AnimatedSprite2D/AudioStreamPlayer2D
@onready var player = get_node("/root/Game/Player")

@export var health = 100
@export var SPEED = 80
enum State {IDLE,AGGRESIVE,STUNNED,DEAD,ATTACKING}
var stun_meter = 0;
var knockback = 0;
@export var state : State
@export var AGGRO_MIN = 100;
@export var AGGRO_RANGE = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#Used to get the angle to the player
func get_angle_toward(thing):
	return (atan2((-position.y + thing.position.y),(-position.x + thing.position.x)))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var distance = sqrt(pow((player.position.y - position.y),2) + pow((player.position.x - position.x),2))
	var angle = get_angle_toward(player)
	if health <= 0:
		state = State.DEAD
	else:
		if knockback < 0:
			knockback = 0
		if knockback:
			position.x += delta * 30 * -(cos(angle)) * knockback
			position.y += delta * 30 * -(sin(angle)) * knockback
			knockback = knockback - 30 * delta
		if stun_meter:
			state = State.STUNNED
		else: 
			if distance > AGGRO_MIN + AGGRO_RANGE:
				if state != State.ATTACKING:
					state = State.IDLE
			else: if distance < AGGRO_MIN:
				if distance < 35:
					state = State.ATTACKING
				else:
					if state != State.ATTACKING:
						$AnimationPlayer.queue("chasing")
						state = State.AGGRESIVE
	
		
	match state:
		State.DEAD:
			if timer.is_stopped():
				timer.start()
		State.AGGRESIVE:
			if audio_stream_player_2d.playing:
				audio_stream_player_2d.play()
			position.x += delta * (cos(angle)) * SPEED
			position.y += delta * (sin(angle)) * SPEED
		State.IDLE:
			audio_stream_player_2d.stop()
		State.STUNNED:
			stun_meter -= 1 * delta
			if stun_meter < 0:
				stun_meter = 0;
		State.ATTACKING:
			if animation_player.current_animation != "attack":
				animation_player.stop()
				animation_player.play("attack")
			if (animation_player.current_animation == "attack") && (animation_player.current_animation_position > .9):
				state =  State.IDLE
		_:
			pass


func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.
