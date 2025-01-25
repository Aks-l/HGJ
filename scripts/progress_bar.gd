extends ColorRect

var maxX
var maxY
var length
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	maxX = Global.viewport[0]
	maxY = Global.viewport[1]
	set_anchor(maxX, 0.5)
	set_anchor(maxY, 0.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	maxX = Global.viewport[0]
	maxY = Global.viewport[1]
	
	var now:float = Global.ehp
	var full:float = Global.mehp
	var factor:float = now/full
	var toRemove = 1-factor
	
	
	position.x = (toRemove*maxX)/2
	position.y = maxY * 0.02
	size.x = maxX - (toRemove*maxX)
	size.y = maxY*0.05
	
