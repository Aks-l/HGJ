extends Node
var viewport = Vector2()
var hud = null
var hp = 3
var mehp = 10
var ehp = mehp

func decHP(amount:int = 1):
	hp-=amount
	if hud: hud.updateHP()
	
func _process(delta):
	viewport = get_viewport().get_visible_rect().size
	

func _onViewportResized():
	viewport = get_viewport().get_visible_rect().size
