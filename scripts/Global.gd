extends Node
var hp = 3
var viewport = Vector2()
var hud = null

func decHP(amount:int = 1):
	hp-=amount
	if hud: hud.updateHP()

func _process(delta):
	viewport = get_viewport().get_visible_rect().size

func _onViewportResized():
	viewport = get_viewport().get_visible_rect().size
