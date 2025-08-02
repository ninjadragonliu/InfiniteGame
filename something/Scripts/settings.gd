extends Control

var email = ""
var details = ""
var code = ""

func _ready():
	$VBoxContainer/General.button_pressed = true
	var UID = $General/UID
	UID.text = Global.player_id

func _on_back_pressed() -> void:
	Global.save_game_data()
	get_tree().change_scene_to_file("res://Scenes/main_page.tscn")

func _on_general_pressed() -> void:
	$VBoxContainer/General.button_pressed = true
	$VBoxContainer/Support.button_pressed = false
	$General.show()
	$Support.hide()

func _on_support_pressed() -> void:
	$VBoxContainer/General.button_pressed = false
	$VBoxContainer/Support.button_pressed = true
	$Support.show()
	$General.hide()

func _on_email_pressed() -> void:
	$Email.show()

func _on_email_confirmed() -> void:
	email = $Email/LineEdit.text
	$Support/Email.text = email

func _on_details_confirmed() -> void:
	details = $Details/TextEdit.text
	$Support/RichTextLabel.text = details

func _on_details_pressed() -> void:
	$Details.show()

func _on_support_submit_pressed() -> void:
	pass # Replace with function body.

func _on_code_submit_pressed() -> void:
	pass # Replace with function body.

func _on_code_pressed() -> void:
	$Code.show()

func _on_code_confirmed() -> void:
	code = $Code/LineEdit.text
	$"General/Redeem Code".text = code
