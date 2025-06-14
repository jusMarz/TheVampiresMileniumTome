extends CharacterBody2D 

const JUMP_VELOCITY = -250.0
@onready var animated_sprite = $AnimatedSprite2D


var spells  = ["Slash", "Fireball"]
var selected_Spell = 0
@export var fireball : PackedScene

@export var speed = 100.0
@export var speed_mult = 1
@export var health = 100
@export var max_health = 100
@export var stun_meter = 0
@export var knockback = 0
@export var level = 1

signal slashes
signal shoots

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var facing_down: String ="facing_down"
var facing_up: String ="facing_up"
var facing_left: String ="facing_left"
var facing_right: String ="facing_right"


@export var slashing = false

func _ready():
	$Camera2D/Exp.connect("increase_level", _on_increaseLevel)
	
	
func _on_increaseLevel():
	print("LEVELED UP")
	health = max_health
	max_health+=15
	speed_mult+=.5
	level+=1

	
	
func isPlayer():
	return true
	
func _process(_delta):
	if Input.is_action_just_pressed("attack"):
		if spells[selected_Spell] == "Slash":
			emit_signal("slashes")
			print("SLASH")
		if spells[selected_Spell] == "Fireball":
			shoot()
			emit_signal("shoots")
			print("SHOOT")
		if spells[selected_Spell] == "Slowdown":
			shoot()
			emit_signal("Slowdown")
			print("SLOWDOWN")
			
	if Input.is_action_just_pressed("switch"):
		var alreadySwitched = false
		selected_Spell+=1
		if(selected_Spell>spells.size()-1):
			selected_Spell=0



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
		speed = sqrt(5000)
	else:
		speed = 100
		 
	speed*=speed_mult
	if direction:
		velocity.x = direction * speed
		if direction > 0:
			animated_sprite.play("right")
			
		if direction < 0:
			animated_sprite.play("left")
				
	else:
		velocity.x = move_toward(velocity.x, 0 , speed)
	if direction2:
		velocity.y = direction2 * speed
		if direction2 <0:
			animated_sprite.play("up")
			
		if direction2 >0:
			animated_sprite.play("down")

		
	else:
		velocity.y = move_toward(velocity.x, 0, speed)
		
	move_and_slide()
	
