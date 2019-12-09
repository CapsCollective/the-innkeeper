extends Node

export (Array) var cups

var cups_available = 8

# count = the amount of cups being taken / put back (negative to put back)
func move_cups(count):
	cups_available -= count
	for i in range(0, cups_available):
		get_node(cups[i]).visible = true
	for i in range(cups_available, cups.size()):
		get_node(cups[i]).visible = false
