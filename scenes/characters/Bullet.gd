extends KinematicBody2D


var velocity = Vector2()

func _ready():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	axis.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	axis = axis.normalized()
	
	if axis.x > 0:
		velocity.x = 1500
		$AnimatedSprite.flip_h = false
	else:
		velocity.x = -1500
		$AnimatedSprite.flip_h = true

func _physics_process(delta):
	move_and_slide(velocity)

func _on_Hurtbox_area_entered(area):
	if area.is_in_group("hurtbox-character"):
		area.get_parent().take_damage(1)
	
	queue_free()
