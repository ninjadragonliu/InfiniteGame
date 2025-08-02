extends Window

func _ready() -> void:
	var current_score = get_tree().current_scene.get_node("Score/Label").text
	$VBoxContainer/Coins.text = "Coins: " + str(Global.coins)
	$VBoxContainer/Diamonds.text = "Diamonds: " + str(Global.coins)
	$Score.text = "Your Score Was " + str(current_score)

func _on_back_to_menu_pressed() -> void:
	#if Global.tutorial_cleared:
		#get_tree().paused = false
		#Global.reset_health()
		#Global.save_game_data()
		#await get_tree().process_frame
		#get_tree().change_scene_to_file("res://Scenes/overworld_map.tscn")
	#else:
		#get_tree().paused = false
		#Global.reset_health()
		#Global.save_game_data()
		#await get_tree().process_frame
		#get_tree().change_scene_to_file("res://Scenes/tutorial.tscn")
		get_tree().paused = false
		await get_tree().process_frame
		get_tree().change_scene_to_file("res://Scenes/main_page.tscn")

func _on_retry_pressed() -> void:
	get_tree().paused = false
	Global.reset_health()
	await get_tree().process_frame  # Wait for the current frame to finish
	get_tree().reload_current_scene()
