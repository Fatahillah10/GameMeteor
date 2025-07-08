extends Control

func _on_restart_button_pressed():
	get_tree().reload_current_scene()  # Restart game saat tombol ditekan
