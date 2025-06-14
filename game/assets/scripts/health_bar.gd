extends ProgressBar

@onready var player = %Player # get it somewhere

# Called when the node enters the scene tree for the first time.
func _ready():
	max_value=player.health
	min_value=0
	pass # Replace with function body.

func _on_increseExp():
	max_value +=15
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value = player.health
	pass
