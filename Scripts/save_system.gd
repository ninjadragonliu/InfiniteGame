extends Node

var save_path := "user://savegame.json"

# Call this to save data
func save_game(data: Dictionary) -> void:
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))
		file.close()
		print("✅ Game Saved")

# Call this to load data
func load_game() -> Dictionary:
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var content = file.get_as_text()
		file.close()
		
		var result = JSON.parse_string(content)
		if typeof(result) == TYPE_DICTIONARY:
			print("✅ Game Loaded")
			return result
	print("⚠️ No save file found or data is corrupted.")
	return {}  # default fallback
