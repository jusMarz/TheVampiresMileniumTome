extends Area2D

@onready var player = %Player
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D

var chase = false
var speed = 3.5
signal increaseExp

func get_angle_to_target_node():
	return (abs(atan2((-position.y + player.position.y),(-position.x + player.position.x))))
	
func _process(delta):
	
	var distance = sqrt(pow((player.position.y - position.y ),2) + pow((player.position.x - position.x),2))
	if distance < 50:
		chase = true
	if distance < 5:
			emit_signal("increaseExp")
			queue_free()
			
	if chase:
		var angle = get_angle_to_target_node()
		position.x += (int(position.x < player.position.x) - int(position.x > player.position.x)) * delta * 30 * abs(cos(angle)) * speed
		position.y += (int(position.y < player.position.y) - int(position.y > player.position.y)) * delta * 30 * abs(sin(angle)) * speed
		speed += .2 * delta
		audio_stream_player_2d.play()
		
	


