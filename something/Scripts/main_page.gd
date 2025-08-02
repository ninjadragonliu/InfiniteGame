extends Control

var profile : PackedScene = load("res://nodes/profile.tscn")

func _ready() -> void:
	$VBoxContainer/ID.text = "ID: " + Global.player_id
	
func _process(delta: float) -> void:
	$VBoxContainer/PlayerName.text = "Player Name: " + Global.player_name
	$VBoxContainer2/Coins.text = "Coins: " + str(Global.coins)
	$VBoxContainer2/Diamonds.text = "Diamonds: " + str(Global.diamonds)

func _on_events_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/events.tscn")

func _on_play_pressed() -> void:
	#if Global.tutorial_cleared:
		#get_tree().change_scene_to_file("res://Scenes/overworld_map.tscn")
	#else:
		#get_tree().change_scene_to_file("res://Scenes/tutorial.tscn")
		get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/settings.tscn")

func _on_shop_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/shop.tscn")

func _on_character_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/character_page.tscn")

func _on_profile_pic_pressed() -> void:
	if profile:
		var popup = profile.instantiate()
		get_tree().current_scene.add_child(popup)
		popup.show()
		
				# Pause the game
		get_tree().paused = true

		# Allow the game over screen to function while paused
		popup.process_mode = Node.PROCESS_MODE_ALWAYS
