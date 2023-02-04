extends Node2D

class_name State

var change_state
var animated_sprite
var animation_tree
var persistent_state
var velocity = 0
var lastMovementAxis = Vector2.RIGHT

# Writing _delta instead of delta here prevents the unused variable warning.
func _physics_process(_delta):
	persistent_state.move_and_slide(persistent_state.velocity, Vector2.UP)

func setup(change_state, animated_sprite, animation_tree, persistent_state):
	self.change_state = change_state
	self.animated_sprite = animated_sprite
	self.animation_tree = animation_tree.get("parameters/playback")
	self.persistent_state = persistent_state

func get_input_axis():
	#if !dashEnabled:
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	axis.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	lastMovementAxis = axis.normalized()
	return axis.normalized()
	#else:
	#	return lastMovementAxis if lastMovementAxis != Vector2.ZERO else Vector2.RIGHT

func move_left():
	pass

func move_right():
	pass
