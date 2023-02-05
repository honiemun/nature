extends State

class_name HittingState

func _ready():
	print("Got Hit")
	if persistent_state.lives != 0:
		animation.travel("hit")
		yield(get_tree().create_timer(0.2), "timeout")
		change_state.call_func("idle")
	else:
		animation.travel("death")
