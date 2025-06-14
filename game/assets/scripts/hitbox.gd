extends Area2D

@onready var diddler = $".."
@export var ALIGNMENT: String
@export var DAMAGE = 25
@export var STUN  = 0.00
@export var KNOCKBACK = 1

func give_stats():
	var attack_stats = [DAMAGE,STUN,KNOCKBACK,"EVIL"] 
	return attack_stats
