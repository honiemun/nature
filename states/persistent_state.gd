extends KinematicBody2D

class_name PersistentState

var state
var state_factory
onready var sprite = $Sprite
onready var hurtbox = $HurtboxArea/Hurtbox
var is_flipped = false

var lives = 3
var velocity = Vector2()

func _ready():
	state_factory = StateFactory.new()
	change_state("idle")

func _physics_process(delta):
	flip_character()

func change_state(new_state_name):
	if state != null:
		state.queue_free()
	state = state_factory.get_state(new_state_name).new()
	state.setup(funcref(self, "change_state"), $Sprite, $AnimationTree, self)
	state.name = "current_state"
	add_child(state)

func flip_character():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	axis.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	axis = axis.normalized()
	
	if is_flipped:
		sprite.flip_h = true
		hurtbox.position.x = -106
	else:
		sprite.flip_h = false
		hurtbox.position.x = 106
	
	if !(axis.x == 0):
		if axis.x >= 0.4:
			is_flipped = false
		elif axis.x <= 0.4:
			is_flipped = true


func _on_HurtboxArea_area_entered(area):
	if area.is_in_group("hurtbox-character"):
		area.get_parent().take_damage(3)

func take_damage():
	lives -= 1
	change_state("hit")
