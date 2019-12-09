extends Node

enum Item {Mead, Ale, Wine, Soup}

export (Item) var item

onready var bar = get_parent()

func interact(player):
	if player.items.size() < player.items_limit and bar.cups_available > 0:
		player.items.append(item)
		bar.cups_available -= 1