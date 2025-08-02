extends Control

func _ready() -> void:
	for i in range(1, Global.tutorial_levels + 1):  # Loop through all level buttons
		var button = get_node("Button" + str(i))  # Find the button (e.g., "Button1", "Button2", etc.)
		
		if i == 1 or (i - 1) in Global.cleared_tutorial_levels:
			button.disabled = false  # Enable the button if it's level 1 or the previous level is cleared
		else:
			button.disabled = true   # Disable the button if the previous level is not cleared

func _process(delta: float) -> void:
	if Global.cleared_tutorial_levels.size() == Global.tutorial_levels:
		Global.tutorial_cleared = true
		get_tree().change_scene_to_file("res://Scenes/overworld_map.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_page.tscn")

func _on_button_1_pressed() -> void:
	Global.tutorial_counter = 1
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_button_2_pressed() -> void:
	Global.tutorial_counter = 2
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_button_3_pressed() -> void:
	Global.tutorial_counter = 3
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_button_4_pressed() -> void:
	Global.tutorial_counter = 4
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_button_5_pressed() -> void:
	Global.tutorial_counter = 5
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
