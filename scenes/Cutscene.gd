extends Control

func _physics_process(delta):
	if Input.is_action_pressed("jab"):
		get_tree().change_scene("res://scenes/MainGame.tscn")

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://scenes/MainGame.tscn")
