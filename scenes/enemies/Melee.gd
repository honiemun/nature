extends KinematicBody2D

onready var player = get_tree().get_root().get_node("MainGame/YSort/Character")
onready var animation_player = $AnimationPlayer
onready var sprite = $Position2D/Sprite
onready var hurtbox = $Hurtbox/Hurtbox

const speed = 7500
var motion = Vector2.ZERO
var isInRange = false
var hasStopped = false
var is_flipped = false
var life = 10

func _physics_process(delta):
	motion = Vector2.ZERO
	
	if player && !hasStopped:
		motion = position.direction_to(player.position) * speed
	motion = move_and_slide(motion * delta)
	flip_character(motion)

func flip_character(motion):
	print(motion)
	
	if is_flipped:
		sprite.flip_h = false
		hurtbox.position.x = 106
	else:
		sprite.flip_h = true
		hurtbox.position.x = -106
	
	if !(motion.x == 0):
		if motion.x >= 0.4:
			is_flipped = false
		elif motion.x <= 0.4:
			is_flipped = true

func _on_DetectionRange_body_entered(body):
	if body.get_name() == "Character":
		hasStopped = true
		animation_player.play("Attack")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Attack":
		hasStopped = false
	elif anim_name == "Hit":
		hasStopped = false
	elif anim_name == "Dead":
		queue_free()

func Melee_SFX():
	$MeleeSFX.play()

func take_damage(lifeTaken):
	life -= lifeTaken
	
	if life <= 0:
		hasStopped = true
		animation_player.play("Dead")
	else:
		hasStopped = true
		animation_player.play("Hit")


func _on_Hurtbox_area_entered(area):
	if area.is_in_group("hurtbox-enemy"):
		area.get_parent().take_damage()
