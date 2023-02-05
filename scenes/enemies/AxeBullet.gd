extends KinematicBody2D

var velocity = Vector2()

func _ready():
	if :
		velocity.x = 1500
		$Position2D/Sprite.flip_h = false
	else:
		velocity.x = -1500
		$Position2D/Sprite.flip_h = true

func _physics_process(delta):
	move_and_slide(velocity)

func _on_Hurtbox_area_entered(area):
	if area.is_in_group("hurtbox-character"):
		area.get_parent().take_damage(1)
	
	queue_free()
