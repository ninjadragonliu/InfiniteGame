extends Control

@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var player_hair = player.get_node("Hair_atk")
@onready var player_shirt = player.get_node("Clothe_atk")
@onready var player_pants = player.get_node("Pants_atk")

var passive_slot = 0

func _ready() -> void:
	$Equipment/Weapon2.button_pressed = true
	$Equipment.show()
	$Skill.hide()
	$Customize.hide()
	$VBoxContainer/Equip.button_pressed = true
	$Skill/Active.button_pressed = true
	$Customize/Hair2.button_pressed = true
	_ready_weapon_page()
	$Panel/Player.text = "Player: " + Global.player_name
	
	
	#print("-----Current Equipment-----")
	#print(Global.saving_list)
	#print("---------------------------")

func _process(delta: float) -> void:
	$Panel/HP.text = "HP: " + str(Global.health)
	$"Panel/Current Equip/Equip 1".text = "Fist".rpad(11) + ": "+ Global.saving_list[0][Global.saving_list[10][0]][0]
	$"Panel/Current Equip/Equip 2".text = "Sword".rpad(7) + ": "+ Global.saving_list[1][Global.saving_list[10][1]][0]
	$"Panel/Current Equip/Equip 3".text = "Lance".rpad(8) + ": "+ Global.saving_list[2][Global.saving_list[10][2]][0]
	$"Panel/Current Equip/Equip 4".text = "Top".rpad(10) + ": "+  Global.saving_list[3][Global.saving_list[10][3]][0]
	$"Panel/Current Equip/Equip 5".text = "Bottom: " + Global.saving_list[4][Global.saving_list[10][4]][0]
	
	$"Panel/Current SKill/Active".text = "Active".rpad(11) + ": " + Global.saving_list[5][Global.saving_list[10][5]][0]
	$"Panel/Current SKill/Passive 1".text = "Passive 1: " + Global.saving_list[6][Global.saving_list[10][6]][0]
	$"Panel/Current SKill/Passive 2".text = "Passive 2: " + Global.saving_list[6][Global.saving_list[10][7]][0]
 
func _ready_weapon_page():
	Global.save_game_data()
	var weapon_grid = $Equipment/Weapon/ScrollContainer/GridContainer
	
	for child in weapon_grid.get_children():
		weapon_grid.remove_child(child)
		child.queue_free()
	
	for i in range(3):
		for weapon in Global.saving_list[i]:
			if weapon[2]:
				#print(weapon)
				var button = TextureButton.new()
				# weapon_name => weapon[0]
				var icon_path = "res://Assets/testing.png" # testing use code
				#var icon_path = "res://Assets/"+weapon[0]+".png"
				
				if ResourceLoader.exists(icon_path):
					button.texture_normal = load(icon_path)
				else:
					print("Icon: " +weapon[0]+ " not found man, try check the asset")
				
				button.ignore_texture_size = true
				button.stretch_mode = 0
				button.custom_minimum_size = Vector2(100,100)
				
				button.connect("pressed", _on_weapon_icon_pressed.bind(i, weapon[0]))
				if weapon[3] == 1:
					button.texture_disabled = load("res://Assets/testing_disabled.png")
					button.disabled = true # Unfinished, change this so that it also dims the image so it shows it can't be pressed
				weapon_grid.add_child(button)

func _ready_top_page():
	Global.save_game_data()
	var armor_grid = $Equipment/Top/ScrollContainer/GridContainer
	
	for child in armor_grid.get_children():
		armor_grid.remove_child(child)
		child.queue_free()
	
	for top in Global.saving_list[3]:
		if top[2]:
			var button = TextureButton.new()
			# top_name => top[0]
			var icon_path = "res://Assets/testing.png" # testing use code
			#var icon_path = "res://Assets/"+top[0]+".png"
			
			if ResourceLoader.exists(icon_path):
				button.texture_normal = load(icon_path)
			else:
				print("Icon: " +top[0]+ " not found man, try check the asset")
			
			button.ignore_texture_size = true
			button.stretch_mode = 0
			button.custom_minimum_size = Vector2(100,100)
			
			button.connect("pressed", _on_top_icon_pressed.bind(top[0]))
			if top[3] == 1:
				button.texture_disabled = load("res://Assets/testing_disabled.png")
				button.disabled = true # Unfinished, change this so that it also dims the image so it shows it can't be pressed
			armor_grid.add_child(button)

func _ready_bottom_page():
	Global.save_game_data()
	var placeholder_grid = $Equipment/Bottom/ScrollContainer/GridContainer
	
	for child in placeholder_grid.get_children():
		placeholder_grid.remove_child(child)
		child.queue_free()
	
	for bottom in Global.saving_list[4]:
		if bottom[2]:
			var button = TextureButton.new()
			# bottom_name => bottom[0]
			var icon_path = "res://Assets/testing.png" # testing use code
			#var icon_path = "res://Assets/"+bottom[0]+".png"
			
			if ResourceLoader.exists(icon_path):
				button.texture_normal = load(icon_path)
			else:
				print("Icon: " +bottom[0]+ " not found man, try check the asset")
			
			button.ignore_texture_size = true
			button.stretch_mode = 0
			button.custom_minimum_size = Vector2(100,100)
			
			button.connect("pressed", _on_bottom_icon_pressed.bind(bottom[0]))
			if bottom[3] == 1:
				button.texture_disabled = load("res://Assets/testing_disabled.png")
				button.disabled = true # Unfinished, change this so that it also dims the image so it shows it can't be pressed
			placeholder_grid.add_child(button)

func _ready_active_page():
	Global.save_game_data()
	var active_skill_grid = $ActiveSkills/ScrollContainer/GridContainer
	
	for child in active_skill_grid.get_children():
		active_skill_grid.remove_child(child)
		child.queue_free()
	
	for skill in Global.saving_list[5]:
		if skill[2] == true:
			var button = TextureButton.new()
			# skill_name => skill[0]
			var icon_path = "res://Assets/testing.png" # testing use code
			#var icon_path = "res://Assets/"+skill[0]+".png"
			
			if ResourceLoader.exists(icon_path):
				button.texture_normal = load(icon_path)
			else:
				print("Icon: " +skill[0]+ " not found man, try check the asset")
			
			button.ignore_texture_size = true
			button.stretch_mode = 0
			button.custom_minimum_size = Vector2(100,100)
			
			button.connect("pressed", _on_active_skill_icon_pressed.bind(skill[0]))
			if skill[3] == 1 and skill[0] != "Empty":
				button.texture_disabled = load("res://Assets/testing_disabled.png")
				button.disabled = true # Unfinished, change this so that it also dims the image so it shows it can't be pressed
			active_skill_grid.add_child(button)

func _ready_passive_page():
	Global.save_game_data()
	passive_slot = 0
	var passive_skill_grid = $PassiveSkills/ScrollContainer/GridContainer
	
	for child in passive_skill_grid.get_children():
		passive_skill_grid.remove_child(child)
		child.queue_free()
	
	for skill in Global.saving_list[6]: 
		if skill[2] == true:
			var button = TextureButton.new()
			# skill_name => skill[0]
			var icon_path = "res://Assets/testing.png" # testing use code
			#var icon_path = "res://Assets/"+skill[0]+".png"
			
			if ResourceLoader.exists(icon_path):
				button.texture_normal = load(icon_path)
			else:
				print("Icon: " +skill[0]+ " not found man, try check the asset")
			
			button.ignore_texture_size = true
			button.stretch_mode = 0
			button.custom_minimum_size = Vector2(100,100)
			
			button.connect("pressed", _on_passive_skill_icon_pressed.bind(skill[0]))
			if skill[3] == 1 and skill[0] != "Empty":
				button.texture_disabled = load("res://Assets/testing_disabled.png")
				button.disabled = true # Unfinished, change this so that it also dims the image so it shows it can't be pressed
			passive_skill_grid.add_child(button)

func _ready_costume_hair_page():
	Global.save_game_data()
	var costume_hair_grid = $Customize/Hair/ScrollContainer/GridContainer
	for child in costume_hair_grid.get_children():
		costume_hair_grid.remove_child(child)
		child.queue_free()
	
	for hair in Global.saving_list[7]:
		if hair[2]:
			var button = TextureButton.new()
			# top_name => top[0]
			var icon_path = "res://Assets/1.png" # testing use code
			#var icon_path = "res://Assets/"+top[0]+".png"
			
			if ResourceLoader.exists(icon_path):
				button.texture_normal = load(icon_path)
			else:
				print("Icon: " +hair[0]+ " not found man, try check the asset")
			
			button.ignore_texture_size = true
			button.stretch_mode = 0
			button.custom_minimum_size = Vector2(100,100)
			
			button.connect("pressed", _on_costume_hair_icon_pressed.bind(hair[0]))
			if hair[3] == 1:
				button.texture_disabled = load("res://Assets/testing_disabled.png")
				button.disabled = true # Unfinished, change this so that it also dims the image so it shows it can't be pressed
			costume_hair_grid.add_child(button)

func _ready_costume_top_page():
	Global.save_game_data()
	var costume_top_grid = $Customize/Top/ScrollContainer/GridContainer
	for child in costume_top_grid.get_children():
		costume_top_grid.remove_child(child)
		child.queue_free()
	
	for top in Global.saving_list[8]:
		if top[2]:
			var button = TextureButton.new()
			# top_name => top[0]
			var icon_path = "res://Assets/3.png" # testing use code
			#var icon_path = "res://Assets/"+top[0]+".png"
			
			if ResourceLoader.exists(icon_path):
				button.texture_normal = load(icon_path)
			else:
				print("Icon: " +top[0]+ " not found man, try check the asset")
			
			button.ignore_texture_size = true
			button.stretch_mode = 0
			button.custom_minimum_size = Vector2(100,100)
			
			button.connect("pressed", _on_costume_top_icon_pressed.bind(top[0]))
			if top[3] == 1:
				button.texture_disabled = load("res://Assets/testing_disabled.png")
				button.disabled = true # Unfinished, change this so that it also dims the image so it shows it can't be pressed
			costume_top_grid.add_child(button)


func _ready_costume_bottom_page():
	Global.save_game_data()
	var costume_bottom_grid = $Customize/Bottom/ScrollContainer/GridContainer
	for child in costume_bottom_grid.get_children():
		costume_bottom_grid.remove_child(child)
		child.queue_free()
	
	for bottom in Global.saving_list[9]:
		if bottom[2]:
			var button = TextureButton.new()
			# top_name => top[0]
			var icon_path = "res://Assets/5.png" # testing use code
			#var icon_path = "res://Assets/"+top[0]+".png"
			
			if ResourceLoader.exists(icon_path):
				button.texture_normal = load(icon_path)
			else:
				print("Icon: " +bottom[0]+ " not found man, try check the asset")
			
			button.ignore_texture_size = true
			button.stretch_mode = 0
			button.custom_minimum_size = Vector2(100,100)
			
			button.connect("pressed", _on_costume_bottom_icon_pressed.bind(bottom[0]))
			if bottom[3] == 1:
				button.texture_disabled = load("res://Assets/testing_disabled.png")
				button.disabled = true # Unfinished, change this so that it also dims the image so it shows it can't be pressed
			costume_bottom_grid.add_child(button)

func _on_weapon_icon_pressed(weapon_type_id, weapon_name):
	var index = 0
	#print("----Unequipped----")
	#print(Global.saving_list[weapon_type_id][Global.saving_list[10][1]])
	#unequip
	Global.saving_list[weapon_type_id][Global.saving_list[10][weapon_type_id]][3] = 0
		
	for weapon in Global.saving_list[weapon_type_id]:
		if weapon[0] == weapon_name:
			weapon[3] = 1
			Global.saving_list[10][weapon_type_id] = index
			break
		index += 1# keep track of index
	#print("----Equipped----")
	#print(Global.saving_list[weapon_type_id][Global.saving_list[10][1]])
	player.update_animation(weapon_type_id)
	var animation = player.get_node("AnimationPlayer")
	animation.play()
	_ready_weapon_page()

func _on_top_icon_pressed(top_name):
	var index = 0
	
	#unequip
	Global.saving_list[3][Global.saving_list[10][3]][3] = 0
	
	for top in Global.saving_list[3]:
		if top[0] == top_name:
			top[3] = 1
			Global.saving_list[10][3] = index
			break
			
		index += 1# keep track of index
	_ready_top_page()

func _on_bottom_icon_pressed(bottom_name):
	var index = 0
	
	#unequip
	Global.saving_list[4][Global.saving_list[10][4]][3] = 0
	
	for bottom in Global.saving_list[4]:
		if bottom[0] == bottom_name:
			bottom[3] = 1
			Global.saving_list[10][4] = index
			break
			
		index += 1# keep track of index
	_ready_bottom_page()

func _on_active_skill_icon_pressed(skill_name):
	var index = 0
	
	#unequip
	Global.saving_list[5][Global.saving_list[10][5]][3] = 0
	
	for skill in Global.saving_list[5]:
		if skill[0] == skill_name:
			skill[3] = 1
			Global.saving_list[10][5] = index
			break
			
		index += 1# keep track of index
	_on_active_skills_close_requested()

func _on_passive_skill_icon_pressed(skill_name):
	#print(skill_name+" skillName\n")
	var index = 0
	var slot = passive_slot+5 #calculate correct slot user are switching
	
	#unequip
	if !(Global.saving_list[10][6] == 0 and Global.saving_list[10][7] == 0):
		Global.saving_list[6][Global.saving_list[10][slot]][3] = 0
	#print(Global.saving_list[6][Global.saving_list[10][slot]])
	
	for skill in Global.saving_list[6]:
		if skill[0] == skill_name:
			skill[3] = 1
			Global.saving_list[10][slot] = index
			#print(skill)
			break
		
		index += 1# keep track of index
	#print(Global.saving_list[6][Global.saving_list[10][slot]][0])
	_on_passive_skills_close_requested()

func _on_costume_hair_icon_pressed(hair_name):
	var index = 0
	
	#unequip
	Global.saving_list[7][Global.saving_list[10][8]][3] = 0
	
	for hair in Global.saving_list[7]:
		if hair[0] == hair_name:
			hair[3] = 1
			Global.saving_list[10][8] = index
			break
			
		index += 1# keep track of index
	#print(Global.saving_list[7][Global.saving_list[10][8]][0])
	#player_hair.texture = load("res://Assets/1.png") # hard coding setting the texture of the hair
	player.update_animation()
	_ready_costume_hair_page()

func _on_costume_top_icon_pressed(top_name):
	var index = 0
	
	#unequip
	Global.saving_list[8][Global.saving_list[10][9]][3] = 0
	
	for top in Global.saving_list[8]:
		if top[0] == top_name:
			top[3] = 1
			Global.saving_list[10][9] = index
			break
			
		index += 1# keep track of index
	#print(Global.saving_list[8][Global.saving_list[10][9]][0])
	#player_shirt.texture = load("res://Assets/1.png") # hard coding setting the texture of the shirt
	player.update_animation()
	_ready_costume_top_page()

func _on_costume_bottom_icon_pressed(bottom_name):
	var index = 0
	
	#unequip
	Global.saving_list[9][Global.saving_list[10][10]][3] = 0
	
	for bottom in Global.saving_list[9]:
		if bottom[0] == bottom_name:
			bottom[3] = 1
			Global.saving_list[10][10] = index
			break
			
		index += 1# keep track of index
	#print(Global.saving_list[9][Global.saving_list[10][10]][0])
	#player_pants.texture = load("res://Assets/5.png") # hard coding setting the texture of the pants
	player.update_animation()
	_ready_costume_bottom_page()


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_page.tscn")

func _on_equip_pressed() -> void:
	$Equipment.show()
	$Skill.hide()
	$Customize.hide()
	$Equipment/Weapon.show()
	$VBoxContainer/Equip.button_pressed = true
	$VBoxContainer/Skill.button_pressed = false
	$VBoxContainer/Customize.button_pressed = false
	_on_weapon_2_pressed()

func _on_skill_pressed() -> void:
	$Equipment.hide()
	$Skill.show()
	$Skill/Active2.show()
	$Skill/Passive2.hide()
	$Customize.hide()
	$VBoxContainer/Equip.button_pressed = false
	$VBoxContainer/Skill.button_pressed = true
	$VBoxContainer/Customize.button_pressed = false

func _on_customize_pressed() -> void:
	$Equipment.hide()
	$Skill.hide()
	$Customize.show()
	$Customize/Hair.show()
	$VBoxContainer/Equip.button_pressed = false
	$VBoxContainer/Skill.button_pressed = false
	$VBoxContainer/Customize.button_pressed = true
	_on_hair_2_pressed()

func _on_weapon_2_pressed() -> void:
	$Equipment/Weapon.show()
	$Equipment/Top.hide()
	$Equipment/Bottom.hide()
	$Equipment/Weapon2.button_pressed = true
	$Equipment/Top2.button_pressed = false
	$Equipment/Bottom2.button_pressed = false
	_ready_weapon_page()

func _on_top_2_pressed() -> void:
	$Equipment/Weapon.hide()
	$Equipment/Top.show()
	$Equipment/Bottom.hide()
	$Equipment/Weapon2.button_pressed = false
	$Equipment/Top2.button_pressed = true
	$Equipment/Bottom2.button_pressed = false
	_ready_top_page()

func _on_bottom_2_pressed() -> void:
	$Equipment/Weapon.hide()
	$Equipment/Top.hide()
	$Equipment/Bottom.show()
	$Equipment/Weapon2.button_pressed = false
	$Equipment/Top2.button_pressed = false
	$Equipment/Bottom2.button_pressed = true
	_ready_bottom_page()

func _on_active_pressed() -> void:
	$Skill/Active.button_pressed = true
	$Skill/Passive.button_pressed = false
	$Skill/Active2.show()
	$Skill/Passive2.hide()

func _on_passive_pressed() -> void:
	$Skill/Active.button_pressed = false
	$Skill/Passive.button_pressed = true
	$Skill/Active2.hide()
	$Skill/Passive2.show()

func _on_passive_skill_1_pressed() -> void:
	_ready_passive_page()
	$PassiveSkills.show()
	passive_slot = 1

func _on_passive_skill_2_pressed() -> void:
	_ready_passive_page()
	$PassiveSkills.show()
	passive_slot = 2

func _on_passive_skills_close_requested() -> void:
	Global.save_game_data()
	$PassiveSkills.hide()

func _on_active_skills_close_requested() -> void:
	Global.save_game_data()
	$ActiveSkills.hide()

func _on_active_skill_1_pressed() -> void:
	_ready_active_page()
	$ActiveSkills.show()

func _on_hair_2_pressed() -> void:
	$Customize/Hair.show()
	$Customize/Top.hide()
	$Customize/Bottom.hide()
	$Customize/Hair2.button_pressed = true
	$Customize/OutfitTop2.button_pressed = false
	$Customize/OutfitBottom2.button_pressed = false
	_ready_costume_hair_page()

func _on_outfit_top_2_pressed() -> void:
	$Customize/Hair.hide()
	$Customize/Top.show()
	$Customize/Bottom.hide()
	$Customize/Hair2.button_pressed = false
	$Customize/OutfitTop2.button_pressed = true
	$Customize/OutfitBottom2.button_pressed = false
	_ready_costume_top_page()

func _on_outfit_bottom_2_pressed() -> void:
	$Customize/Hair.hide()
	$Customize/Top.hide()
	$Customize/Bottom.show()
	$Customize/Hair2.button_pressed = false
	$Customize/OutfitTop2.button_pressed = false
	$Customize/OutfitBottom2.button_pressed = true
	_ready_costume_bottom_page()
