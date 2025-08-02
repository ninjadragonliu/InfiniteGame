extends Window

var temp = Global.max_health/3
var temp2 = temp*2
func _ready() -> void:
	Global.coins += Global.mapNumber * 100 + Global.level * 10
	$VBoxContainer/Coins.text = "Coins: " + str(Global.coins)
	$VBoxContainer/Diamonds.text = "Diamonds: " + str(Global.diamonds)
	if Global.health == Global.max_health:
		$"Stars/Star 1".frame = 0
		$"Stars/Star 2".frame = 0
		$"Stars/Star 3".frame = 0
	elif Global.health >= temp2:
		$"Stars/Star 1".frame = 0
		$"Stars/Star 2".frame = 0
		$"Stars/Star 3".frame = 1
	elif Global.health >= temp:
		$"Stars/Star 1".frame = 0
		$"Stars/Star 2".frame = 1
		$"Stars/Star 3".frame = 1
	else:
		$"Stars/Star 1".frame = 1
		$"Stars/Star 2".frame = 1
		$"Stars/Star 3".frame = 1

func _on_ok_pressed() -> void:
	if Global.tutorial_cleared:
		get_tree().paused = false
		Global.reset_health()
		Global.save_game_data()
		await get_tree().process_frame
		get_tree().change_scene_to_file("res://Scenes/overworld_map.tscn")
	else:
		get_tree().paused = false
		Global.reset_health()
		Global.save_game_data()
		await get_tree().process_frame
		get_tree().change_scene_to_file("res://Scenes/tutorial.tscn")

func _on_next_level_pressed() -> void:
	if Global.level < Global.levels_in_map and Global.tutorial_cleared:
		get_tree().paused = false
		Global.level += 1
		Global.save_game_data()
		await get_tree().process_frame
		get_tree().change_scene_to_file("res://Scenes/world.tscn")
	else:
		get_tree().paused = false
		Global.tutorial_counter += 1
		Global.save_game_data()
		await get_tree().process_frame
		get_tree().change_scene_to_file("res://Scenes/world.tscn")
