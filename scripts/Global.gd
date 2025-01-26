extends Node

var viewport = Vector2()

#player hitoints
var hp = 3

#max and current enemy hitpoints
var mehp = 5
var ehp = mehp

func _process(delta):
	viewport = get_viewport().get_visible_rect().size
