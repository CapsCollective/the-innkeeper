extends Node

onready var bar = get_parent()

func interact(player):
	print('sink')
	bar.cups_available += player.items.size()
	player.items = []