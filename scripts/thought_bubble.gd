extends AnimationPlayer

func _animation_ended():
	play("idle")

func _show_icon():
	get_parent().get_child(0).visible = true
