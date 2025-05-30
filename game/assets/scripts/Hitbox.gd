extends Area2D

@onready var diddler = $".."
@export var ALIGNMENT: String
@export var DAMAGE = 99
@export var STUN  = 0.00
@export var KNOCKBACK = 1

pass

func get_stats(index):
	var attack_stats = [DAMAGE,STUN,KNOCKBACK] 
	return attack_stats[index]
