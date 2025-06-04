extends CharacterBody2D 

const JUMP_VELOCITY = -250.0
@onready var animated_sprite = $AnimatedSprite2D
var spells  = ["Slash", "Fireball"]
var selected_Spell = "Slash"
@export var fireball : PackedScene

@export var SPEED = 100.0
@export var health = 100
@export var stun_meter = 0;
@export var knockback = 0;

signal slashes
signal shoots

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
		if selected_Spell == "Slash":
			emit_signal("slashes")
			print("SLASH")
		if selected_Spell == "Fireball":
			shoot()
			emit_signal("shoots")
			print("SHOOT")
			
	if Input.is_action_just_pressed("switch"):
		var alreadySwitched = false
		if selected_Spell == spells[1] and !alreadySwitched:
			selected_Spell = spells[0]
			print("SWITCHED TO SLASH")
			alreadySwitched = true
		if selected_Spell == spells[0] and !alreadySwitched:
			selected_Spell = spells[1]
			print("SWITCHED TO FIREBALL")
			alreadySwitched = true



func shoot():
	var f = fireball.instantiate()
	owner.add_child(f)
	f.transform = $Node2D.global_transform
	
	
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
	var direction = Input.get_axis("a", "d")
	var direction2 = Input.get_axis("w", "s")

	
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
	
