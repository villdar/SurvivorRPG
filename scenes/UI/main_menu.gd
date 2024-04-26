extends CanvasLayer


func _ready():
	%PlayButton.pressed.connect(on_play_pressed)
	%OptionsButton.pressed.connect(on_options_pressed)
	%QuitButton.pressed.connect(on_quit_pressed)
	$AnimationPlayer.animation_finished.connect(on_animation_finished)
	$Timer.timeout.connect(on_timer_timeout)
	


func on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func on_options_pressed():
	pass


func on_quit_pressed():
	get_tree().quit()


func on_animation_finished(animation_name):
	$Timer.start()


func on_timer_timeout():
	$AnimationPlayer.play("title")
