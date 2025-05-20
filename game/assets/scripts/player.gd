extends CharacterBody2D 


var SPEED = 100.0
const JUMP_VELOCITY = -250.0
@onready var animated_sprite = $AnimatedSprite2D
@onready var animation = $AnimationPlayer
signal slashes

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var facing_down: String ="facing_down"
var facing_up: String ="facing_up"
var facing_left: String ="facing_left"
var facing_right: String ="facing_right"


@export var slashing = false


func isPlayer():
	return true
	
func _process(_delta):
	if Input.is_action_just_pressed("attack"):
		emit_signal("slashes")
		print("dwedqw")


	
	
func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	var direction2 = Input.get_axis("ui_up", "ui_down")

	
	if direction and direction2:
		SPEED = sqrt(5000)
	else:
		SPEED = 100
		 
	if direction:
		velocity.x = direction * SPEED
		if direction > 0:
			animated_sprite.play("right")
			
		if direction < 0:
			animated_sprite.play("left")
				
	else:
		velocity.x = move_toward(velocity.x, 0 , SPEED)
	if direction2:
		velocity.y = direction2 * SPEED
		if direction2 <0:
			animated_sprite.play("up")
			
		if direction2 >0:
			animated_sprite.play("down")

		
	else:
		velocity.y = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
	
