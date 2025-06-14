extends Node2D
@onready var timer = $Timer

#enemy stats

@onready var animation_player = $AnimationPlayer
@onready var audio_stream_player_2d = $AnimatedSprite2D/AudioStreamPlayer2D
@onready var player = get_node("/root/Game/Player")

@export var health = 100
@export var SPEED = 80
enum State {Idle,Aggresive,Stunned,Dead,Attacking}
var stun_meter = 0;
var knockback = 0;
@export var state : State
@export var AGGRO_MIN = 200;
@export var AGGRO_RANGE = 200

@export var DAMAGE = 15
@export var STUN  = 0.0
@export var KNOCKBACK = 1


@export var coin : PackedScene

signal get_experience

# Called when the node enters the scene tree for the first time.
func _ready():
	var exp_bar = get_node_or_null("/root/Game/Player/Camera2D/Exp")
	if exp_bar and not get_experience.is_connected(exp_bar._on_increaseExp):
		get_experience.connect(exp_bar._on_increaseExp)

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
				if state != State.Attacking:
					state = State.Idle
			else: if distance < AGGRO_MIN:
				if distance < 35:
					state = State.Attacking
				else:
					if state != State.Attacking:
						$AnimationPlayer.queue("chasing")
						state = State.Aggresive
	
		
	match state:
		State.Dead:
			if timer.is_stopped():
				print("timer start")
				timer.start()
				emit_signal("get_experience")
				spawnCoins()
		State.Aggresive:
			if audio_stream_player_2d.playing:
				audio_stream_player_2d.play()
			position.x += delta * (cos(angle)) * SPEED
			position.y += delta * (sin(angle)) * SPEED
		State.Idle:
			audio_stream_player_2d.stop()
			animation_player.play("chasing")
		State.Stunned:
			stun_meter -= 1 * delta
			if stun_meter < 0:
				stun_meter = 0;
		State.Attacking:
			if animation_player.current_animation != "attack":
				animation_player.stop()
				animation_player.play("attack")
			if (animation_player.current_animation == "attack") && (animation_player.current_animation_position > .9):
				state =  State.Idle
		_:
			pass

func spawnCoins():
	pass
	#var c = coin.instantiate()
	#owner.add_child(c)
	##c.transform = $Node2D.global_transform
	
	
func _on_timer_timeout():
	print("HEY")
	queue_free()
	pass # Replace with function body.

func give_stats():
	var attack_stats = [DAMAGE,STUN,KNOCKBACK,"EVIL"] 
	return attack_stats
