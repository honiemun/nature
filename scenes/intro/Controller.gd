extends Control


func _on_anim_finish():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
