extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	$"../../../Coin".connect("increaseExp", _on_increaseExp)

func _on_increaseExp():
	value+=15
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
