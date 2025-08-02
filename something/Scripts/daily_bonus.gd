extends Control

signal daily_login_finished

func _on_back_pressed() -> void:
	$TextureRect.show()
	await get_tree().create_timer(3.0).timeout
	emit_signal("daily_login_finished")
	queue_free()
