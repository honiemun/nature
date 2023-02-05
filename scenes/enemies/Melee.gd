extends KinematicBody2D

onready var player = get_tree().get_root().get_node("MainGame/YSort/Character")
onready var animation_player = $AnimationPlayer

const speed = 7500
var motion = Vector2.ZERO
var isInRange = false
var hasStopped = false
var life = 10

func _physics_process(delta):
	motion = Vector2.ZERO
	
	if player && !hasStopped:
		motion = position.direction_to(player.position) * speed
	motion = move_and_slide(motion * delta)


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
