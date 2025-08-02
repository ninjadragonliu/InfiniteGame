extends Control

func _ready() -> void:
	Global.load_data()
	
	if should_show_daily_login():
		var daily_login = preload("res://Scenes/daily_bonus.tscn").instantiate()
		daily_login.connect("daily_login_finished", Callable(self, "_on_daily_login_finished"))
		add_child(daily_login)
	else:
		await get_tree().process_frame
		get_tree().change_scene_to_file("res://Scenes/main_page.tscn")

func should_show_daily_login() -> bool:
	var last_login = Global.last_login_date  # however you store it
	var current_date = Time.get_date_string_from_system()

	if last_login != current_date:
		Global.last_login_date = current_date
		Global.save_game_data()
		return true
	return false

func _on_daily_login_finished():
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://Scenes/main_page.tscn")
