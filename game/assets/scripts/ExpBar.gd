extends ProgressBar

@onready var diddler = $"../../../Diddler"
signal increaseLevel 
# Called when the node enters the scene tree for the first time.
func _ready():
	$"../../../Diddler".connect("getExperience", _on_increaseExp)

func _on_increaseExp():
	value+=35
	print("INCREASE EXP")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if value>=100:
		emit_signal("increaseLevel")
		value-=100
	pass
