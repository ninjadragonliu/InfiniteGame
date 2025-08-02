extends Control

func _ready() -> void:
	for i in range(1, Global.levels_in_map + 1):  # Loop through all level buttons
		var button = get_node("Button " + str(i))  # Find the button (e.g., "Button1", "Button2", etc.)
		
		if i == 1 or (i - 1) in Global.cleared_levels:
			button.disabled = false  # Enable the button if it's level 1 or the previous level is cleared
		else:
			button.disabled = true   # Disable the button if the previous level is not cleared

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_page.tscn")

func _on_button_1_pressed() -> void:
	Global.level = 1
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_button_2_pressed() -> void:
	Global.level = 2
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_button_3_pressed() -> void:
	Global.level = 3
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_button_4_pressed() -> void:
	Global.level = 4
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_button_5_pressed() -> void:
	Global.level = 5
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_button_6_pressed() -> void:
	Global.level = 6
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_button_7_pressed() -> void:
	Global.level = 7
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_button_8_pressed() -> void:
	Global.level = 8
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_button_9_pressed() -> void:
	Global.level = 9
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_button_10_pressed() -> void:
	Global.level = 10
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_button_11_pressed() -> void:
	Global.level = 11
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
