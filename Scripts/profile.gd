extends Window

func _ready() -> void:
	
	$VBoxContainer/ID.text = "ID: " + Global.player_id
	
	if Global.vip_status:
		$VBoxContainer/TextureRect.show()

func _process(delta: float) -> void:
	$VBoxContainer/PlayerName.text = "Player Name: " + Global.player_name
	$Introduction.text = Global.intro_text

func _on_back_pressed() -> void:
	get_tree().paused = false
	await get_tree().process_frame
	hide()

func _on_popup_confirmed() -> void:
	if $Name/LineEdit.text == Global.player_name:
		print("Your name is already this.")
	else:
		Global.player_name = $Name/LineEdit.text

func _on_texture_button_pressed() -> void:
	$Name.show()
	$Name/LineEdit.placeholder_text = "Enter new player name"

func _on_accept_dialog_confirmed() -> void:
	Global.intro_text = $Intro/TextEdit.text

func _on_button_pressed() -> void:
	$Intro.show()
	$Intro/TextEdit.text = $Introduction.text
