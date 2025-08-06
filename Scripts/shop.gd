extends Control

@onready var store_item_scene = preload("res://Scenes/store_item.tscn")

func _ready() -> void:
	$ScrollContainer/VBoxContainer/Featured.button_pressed = true
	_on_featured_pressed()

func _process(delta: float) -> void:
	$VBoxContainer2/Coins/Label.text = str(Global.coins)
	$VBoxContainer2/Diamonds/Label.text =  str(Global.diamonds)

func _on_back_pressed() -> void:
	Global.save_game_data()
	get_tree().change_scene_to_file("res://Scenes/main_page.tscn")

func _on_featured_pressed() -> void:
	_ready_shop_feature_page()
	$Featured.show()
	$Equipment.hide()
	$Weapons.hide()
	$Skills.hide()
	$Costume.hide()
	for child in $ScrollContainer/VBoxContainer/Costume.get_children():
		if child.name.begins_with("Costume"):
			continue
		child.button_pressed = false
	for child in $ScrollContainer/VBoxContainer/Skills.get_children():
		if child.name.begins_with("Skills"):
			continue
		child.button_pressed = false
	for child in $ScrollContainer/VBoxContainer/Weapons.get_children():
		if child.name.begins_with("Weapons"):
			continue
		child.button_pressed = false
	for child in $ScrollContainer/VBoxContainer/Equipment.get_children():
		if child.name.begins_with("Equipment"):
			continue
		child.button_pressed = false

func _ready_shop_feature_page():
	var shop_feature_grid = $Featured/ScrollContainer/GridContainer
	
	for child in shop_feature_grid.get_children():
		shop_feature_grid.remove_child(child)
		child.queue_free()
	
	for i in range(11):
		for item in Global.saving_list[i]:
			if item[7] == true:
				var itemSlot = store_item_scene.instantiate()
				var textureRect_path = "res://Assets/testing.png" # testing use code
				#var icon_path = "res://Assets/"+item[0]+".png"
				
				if ResourceLoader.exists(textureRect_path):
					itemSlot.get_node("itemName").text = item[0]
					itemSlot.get_node("TextureRect").texture = load(textureRect_path)
					
					#.texture_normal = load(icon_path)
				else:
					print("Icon: " +item[0]+ " not found man, try check the asset")
				
				#var icon_path = "res://Assets/"+item[0]+".png"
				var icon_path = "res://Assets/stars.png"
				itemSlot.get_node("Buy").icon = load(icon_path)
				
				if item[7]:
					itemSlot.get_node("Buy").text = str(int(item[8]))
				elif item[6]:
					itemSlot.get_node("Buy").text = str(int(item[5]))
				
				itemSlot.get_node("Buy").connect("pressed", _on_buy_pressed.bind(i, item, true))
				if item[2] == true:
					itemSlot.get_node("Buy").disabled = true
					itemSlot.get_node("Buy").text = "Bought"
				shop_feature_grid.add_child(itemSlot)

func _on_buy_pressed(i, item, isFeaturePage = false) -> void:
	var cost = 0
	
	if item[7]:
		cost = int(item[8])
	elif item[6]:
		cost = int(item[5])
	
	match(item[4]):
		"diamond":
			if Global.diamonds < cost:
				print("Not enough diamond")
				return
			else:
				Global.diamonds -= cost
		"coin":
			if Global.coins < cost:
				print("Not enough coins")
				return
			else:
				Global.coins -= cost
	
	for target in Global.saving_list[i]:
		if target == item:
			target[2] = true
	
	if item[7] and isFeaturePage:
		_ready_shop_feature_page()
	else:
		match i:
			0:
				_on_fist_pressed()
			1:
				_on_sword_pressed()
			2:
				_on_lance_pressed()
			3:
				_on_equip_top_pressed()
			4:
				_on_equip_bottom_pressed()
			5:
				_on_active_pressed()
			6:
				_on_passive_pressed()
			8:
				_on_hair_pressed()
			9:
				_on_costop_pressed()
			10:
				_on_cosbottom_pressed()
			_:
				print("Unable to find what page of shop to jump to after purchase in shop: "+item[0])

func _on_costume_toggled(toggled_on: bool) -> void:
	if toggled_on:
		#$Costume.show()
		#$Featured.hide()
		for child in $ScrollContainer/VBoxContainer/Costume.get_children():
			child.show()
	else:
		#$Costume.hide()
		for child in $Costume.get_children():
			child.hide()
		for child in $ScrollContainer/VBoxContainer/Costume.get_children():
			if child.name.begins_with("Costume"):
				continue
			child.button_pressed = false
			child.hide()

func _on_skills_toggled(toggled_on: bool) -> void:
	if toggled_on:
		for child in $ScrollContainer/VBoxContainer/Skills.get_children():
			child.show()
	else:
		for child in $Skills.get_children():
			child.hide()
		for child in $ScrollContainer/VBoxContainer/Skills.get_children():
			if child.name.begins_with("Skills"):
				continue
			child.button_pressed = false
			child.hide()

func _on_weapons_toggled(toggled_on: bool) -> void:
	if toggled_on:
		for child in $ScrollContainer/VBoxContainer/Weapons.get_children():
			child.show()
	else:
		for child in $Weapons.get_children():
			child.hide()
		for child in $ScrollContainer/VBoxContainer/Weapons.get_children():
			if child.name.begins_with("Weapons"):
				continue
			child.button_pressed = false
			child.hide()

func _on_equipment_toggled(toggled_on: bool) -> void:
	if toggled_on:
		for child in $ScrollContainer/VBoxContainer/Equipment.get_children():
			child.show()
	else:
		for child in $Equipment.get_children():
			child.hide()
		for child in $ScrollContainer/VBoxContainer/Equipment.get_children():
			if child.name.begins_with("Equipment"):
				continue
			child.button_pressed = false
			child.hide()

func _on_hair_pressed() -> void:
	$Costume.show()
	$Featured.hide()
	$Skills.hide()
	$Weapons.hide()
	$Equipment.hide()
	for child in $ScrollContainer/VBoxContainer/Costume.get_children():
		if child.name.begins_with("Costume"):
			continue
		elif child.name.begins_with("Hair"):
			child.button_pressed = true
			continue
		child.button_pressed = false

	for child in $Costume.get_children():
		if child.name.begins_with("Hair"):
			child.show()
			continue
		child.hide()
	
	for child in $ScrollContainer/VBoxContainer/Skills.get_children():
		if child.name.begins_with("Skills"):
			continue
		child.button_pressed = false
	for child in $ScrollContainer/VBoxContainer/Weapons.get_children():
		if child.name.begins_with("Weapons"):
			continue
		child.button_pressed = false
	for child in $ScrollContainer/VBoxContainer/Equipment.get_children():
		if child.name.begins_with("Equipment"):
			continue
		child.button_pressed = false

func _on_costop_pressed() -> void:
	$Costume.show()
	$Featured.hide()
	$Skills.hide()
	$Weapons.hide()
	$Equipment.hide()
	for child in $ScrollContainer/VBoxContainer/Costume.get_children():
		if child.name.begins_with("Costume"):
			continue
		elif child.name.begins_with("CosTop"):
			child.button_pressed = true
			continue
		child.button_pressed = false

	for child in $Costume.get_children():
		if child.name.begins_with("Top"):
			child.show()
			continue
		child.hide()
	
	for child in $ScrollContainer/VBoxContainer/Skills.get_children():
		if child.name.begins_with("Skills"):
			continue
		child.button_pressed = false
	for child in $ScrollContainer/VBoxContainer/Weapons.get_children():
		if child.name.begins_with("Weapons"):
			continue
		child.button_pressed = false
	for child in $ScrollContainer/VBoxContainer/Equipment.get_children():
		if child.name.begins_with("Equipment"):
			continue
		child.button_pressed = false

func _on_cosbottom_pressed() -> void:
	$Costume.show()
	$Featured.hide()
	$Skills.hide()
	$Weapons.hide()
	$Equipment.hide()
	for child in $ScrollContainer/VBoxContainer/Costume.get_children():
		if child.name.begins_with("Costume"):
			continue
		elif child.name.begins_with("CosBottom"):
			child.button_pressed = true
			continue
		child.button_pressed = false
	
	for child in $Costume.get_children():
		if child.name.begins_with("Bottom"):
			child.show()
			continue
		child.hide()
		
	for child in $ScrollContainer/VBoxContainer/Skills.get_children():
		if child.name.begins_with("Skills"):
			continue
		child.button_pressed = false
	for child in $ScrollContainer/VBoxContainer/Weapons.get_children():
		if child.name.begins_with("Weapons"):
			continue
		child.button_pressed = false
	for child in $ScrollContainer/VBoxContainer/Equipment.get_children():
		if child.name.begins_with("Equipment"):
			continue
		child.button_pressed = false

func _on_active_pressed() -> void: # active skills
	$Skills.show()
	$Featured.hide()
	$Costume.hide()
	$Weapons.hide()
	$Equipment.hide()
	for child in $ScrollContainer/VBoxContainer/Skills.get_children():
		if child.name.begins_with("Skills"):
			continue
		elif child.name.begins_with("Active"):
			child.button_pressed = true
			continue
		child.button_pressed = false

	for child in $Skills.get_children():
		if child.name.begins_with("Active"):
			child.show()
			continue
		child.hide()
	
	for child in $ScrollContainer/VBoxContainer/Weapons.get_children():
		if child.name.begins_with("Weapons"):
			continue
		child.button_pressed = false
	for child in $ScrollContainer/VBoxContainer/Equipment.get_children():
		if child.name.begins_with("Equipment"):
			continue
		child.button_pressed = false
	for child in $ScrollContainer/VBoxContainer/Costume.get_children():
		if child.name.begins_with("Costume"):
			continue
		child.button_pressed = false
	
	var shop_active_grid = $Skills/Active/ScrollContainer/GridContainer
	
	for child in shop_active_grid.get_children():
		shop_active_grid.remove_child(child)
		child.queue_free()
	
	for item in Global.saving_list[5]:
		if item[6] == true:
			var itemSlot = store_item_scene.instantiate()
			var textureRect_path = "res://Assets/testing.png" # testing use code
			#var icon_path = "res://Assets/"+item[0]+".png"
			
			if ResourceLoader.exists(textureRect_path):
				itemSlot.get_node("itemName").text = item[0]
				itemSlot.get_node("TextureRect").texture = load(textureRect_path)
				
				#.texture_normal = load(icon_path)
			else:
				print("Icon: " +item[0]+ " not found man, try check the asset")
			
			#var icon_path = "res://Assets/"+item[0]+".png"
			var icon_path = "res://Assets/stars.png"
			itemSlot.get_node("Buy").icon = load(icon_path)
			
			#if item[7]:
			#	itemSlot.get_node("Buy").text = str(int(item[8]))
			#elif item[6]:
			itemSlot.get_node("Buy").text = str(int(item[5]))
			
			itemSlot.get_node("Buy").connect("pressed", _on_buy_pressed.bind(5, item))
			if item[2] == true:
				itemSlot.get_node("Buy").disabled = true
				itemSlot.get_node("Buy").text = "Bought"
			shop_active_grid.add_child(itemSlot)

func _on_passive_pressed() -> void: # passive skills
	$Skills.show()
	$Featured.hide()
	$Costume.hide()
	$Weapons.hide()
	$Equipment.hide()
	for child in $ScrollContainer/VBoxContainer/Skills.get_children():
		if child.name.begins_with("Skills"):
			continue
		elif child.name.begins_with("Passive"):
			child.button_pressed = true
			continue
		child.button_pressed = false

	for child in $Skills.get_children():
		if child.name.begins_with("Passive"):
			child.show()
			continue
		child.hide()
	
	for child in $ScrollContainer/VBoxContainer/Weapons.get_children():
		if child.name.begins_with("Weapons"):
			continue
		child.button_pressed = false
	for child in $ScrollContainer/VBoxContainer/Equipment.get_children():
		if child.name.begins_with("Equipment"):
			continue
		child.button_pressed = false
	for child in $ScrollContainer/VBoxContainer/Costume.get_children():
		if child.name.begins_with("Costume"):
			continue
		child.button_pressed = false
	
	var shop_passive_grid = $Skills/Passive/ScrollContainer/GridContainer
	
	for child in shop_passive_grid.get_children():
		shop_passive_grid.remove_child(child)
		child.queue_free()
	
	for item in Global.saving_list[6]:
		if item[6] == true:
			var itemSlot = store_item_scene.instantiate()
			var textureRect_path = "res://Assets/testing.png" # testing use code
			#var icon_path = "res://Assets/"+item[0]+".png"
			
			if ResourceLoader.exists(textureRect_path):
				itemSlot.get_node("itemName").text = item[0]
				itemSlot.get_node("TextureRect").texture = load(textureRect_path)
				
				#.texture_normal = load(icon_path)
			else:
				print("Icon: " +item[0]+ " not found man, try check the asset")
			
			#var icon_path = "res://Assets/"+item[0]+".png"
			var icon_path = "res://Assets/stars.png"
			itemSlot.get_node("Buy").icon = load(icon_path)
			
			#if item[7]:
			#	itemSlot.get_node("Buy").text = str(int(item[8]))
			#elif item[6]:
			itemSlot.get_node("Buy").text = str(int(item[5]))
			
			itemSlot.get_node("Buy").connect("pressed", _on_buy_pressed.bind(6, item))
			if item[2] == true:
				itemSlot.get_node("Buy").disabled = true
				itemSlot.get_node("Buy").text = "Bought"
			shop_passive_grid.add_child(itemSlot)

func _on_fist_pressed() -> void: # fist
	$Weapons.show()
	$Featured.hide()
	$Costume.hide()
	$Skills.hide()
	$Equipment.hide()
	for child in $ScrollContainer/VBoxContainer/Weapons.get_children():
		if child.name.begins_with("Weapons"):
			continue
		elif child.name.begins_with("Fist"):
			child.button_pressed = true
			continue
		child.button_pressed = false

	for child in $Weapons.get_children():
		if child.name.begins_with("Fist"):
			child.show()
			continue
		child.hide()
	
	for child in $ScrollContainer/VBoxContainer/Costume.get_children():
		if child.name.begins_with("Costume"):
			continue
		child.button_pressed = false
	for child in $ScrollContainer/VBoxContainer/Skills.get_children():
		if child.name.begins_with("Skills"):
			continue
		child.button_pressed = false
	for child in $ScrollContainer/VBoxContainer/Equipment.get_children():
		if child.name.begins_with("Equipment"):
			continue
		child.button_pressed = false
		
	var shop_fist_grid = $Weapons/Fist/ScrollContainer/GridContainer
	
	for child in shop_fist_grid.get_children():
		shop_fist_grid.remove_child(child)
		child.queue_free()
	
	for item in Global.saving_list[0]:
		if item[6] == true:
			var itemSlot = store_item_scene.instantiate()
			var textureRect_path = "res://Assets/testing.png" # testing use code
			#var icon_path = "res://Assets/"+item[0]+".png"
			
			if ResourceLoader.exists(textureRect_path):
				itemSlot.get_node("itemName").text = item[0]
				itemSlot.get_node("TextureRect").texture = load(textureRect_path)
				
				#.texture_normal = load(icon_path)
			else:
				print("Icon: " +item[0]+ " not found man, try check the asset")
			
			#var icon_path = "res://Assets/"+item[0]+".png"
			var icon_path = "res://Assets/stars.png"
			itemSlot.get_node("Buy").icon = load(icon_path)
			
			#if item[7]:
			#	itemSlot.get_node("Buy").text = str(int(item[8]))
			#elif item[6]:
			itemSlot.get_node("Buy").text = str(int(item[5]))
			
			itemSlot.get_node("Buy").connect("pressed", _on_buy_pressed.bind(0, item))
			if item[2] == true:
				itemSlot.get_node("Buy").disabled = true
				itemSlot.get_node("Buy").text = "Bought"
			shop_fist_grid.add_child(itemSlot)

func _on_sword_pressed() -> void:
	$Weapons.show()
	$Featured.hide()
	$Costume.hide()
	$Skills.hide()
	$Equipment.hide()
	for child in $ScrollContainer/VBoxContainer/Weapons.get_children():
		if child.name.begins_with("Weapons"):
			continue
		elif child.name.begins_with("Sword"):
			child.button_pressed = true
			continue
		child.button_pressed = false

	for child in $Weapons.get_children():
		if child.name.begins_with("Sword"):
			child.show()
			continue
		child.hide()
	
	for child in $ScrollContainer/VBoxContainer/Costume.get_children():
		if child.name.begins_with("Costume"):
			continue
		child.button_pressed = false
	for child in $ScrollContainer/VBoxContainer/Skills.get_children():
		if child.name.begins_with("Skills"):
			continue
		child.button_pressed = false
	for child in $ScrollContainer/VBoxContainer/Equipment.get_children():
		if child.name.begins_with("Equipment"):
			continue
		child.button_pressed = false
		
	var shop_sword_grid = $Weapons/Sword/ScrollContainer/GridContainer
	
	for child in shop_sword_grid.get_children():
		shop_sword_grid.remove_child(child)
		child.queue_free()
	
	for item in Global.saving_list[1]:
		if item[6] == true:
			var itemSlot = store_item_scene.instantiate()
			var textureRect_path = "res://Assets/testing.png" # testing use code
			#var icon_path = "res://Assets/"+item[0]+".png"
			
			if ResourceLoader.exists(textureRect_path):
				itemSlot.get_node("itemName").text = item[0]
				itemSlot.get_node("TextureRect").texture = load(textureRect_path)
				
				#.texture_normal = load(icon_path)
			else:
				print("Icon: " +item[0]+ " not found man, try check the asset")
			
			#var icon_path = "res://Assets/"+item[0]+".png"
			var icon_path = "res://Assets/stars.png"
			itemSlot.get_node("Buy").icon = load(icon_path)
			
			#if item[7]:
			#	itemSlot.get_node("Buy").text = str(int(item[8]))
			#elif item[6]:
			itemSlot.get_node("Buy").text = str(int(item[5]))
			
			itemSlot.get_node("Buy").connect("pressed", _on_buy_pressed.bind(1, item))
			if item[2] == true:
				itemSlot.get_node("Buy").disabled = true
				itemSlot.get_node("Buy").text = "Bought"
			shop_sword_grid.add_child(itemSlot)

func _on_lance_pressed() -> void:
	$Weapons.show()
	$Featured.hide()
	$Costume.hide()
	$Skills.hide()
	$Equipment.hide()
	for child in $ScrollContainer/VBoxContainer/Weapons.get_children():
		if child.name.begins_with("Weapons"):
			continue
		elif child.name.begins_with("Lance"):
			child.button_pressed = true
			continue
		child.button_pressed = false

	for child in $Weapons.get_children():
		if child.name.begins_with("Lance"):
			child.show()
			continue
		child.hide()
	
	for child in $ScrollContainer/VBoxContainer/Costume.get_children():
		if child.name.begins_with("Costume"):
			continue
		child.button_pressed = false
	for child in $ScrollContainer/VBoxContainer/Skills.get_children():
		if child.name.begins_with("Skills"):
			continue
		child.button_pressed = false
	for child in $ScrollContainer/VBoxContainer/Equipment.get_children():
		if child.name.begins_with("Equipment"):
			continue
		child.button_pressed = false
		
	var shop_lance_grid = $Weapons/Lance/ScrollContainer/GridContainer
	
	for child in shop_lance_grid.get_children():
		shop_lance_grid.remove_child(child)
		child.queue_free()
	
	for item in Global.saving_list[2]:
		if item[6] == true:
			var itemSlot = store_item_scene.instantiate()
			var textureRect_path = "res://Assets/testing.png" # testing use code
			#var icon_path = "res://Assets/"+item[0]+".png"
			
			if ResourceLoader.exists(textureRect_path):
				itemSlot.get_node("itemName").text = item[0]
				itemSlot.get_node("TextureRect").texture = load(textureRect_path)
				
				#.texture_normal = load(icon_path)
			else:
				print("Icon: " +item[0]+ " not found man, try check the asset")
			
			#var icon_path = "res://Assets/"+item[0]+".png"
			var icon_path = "res://Assets/stars.png"
			itemSlot.get_node("Buy").icon = load(icon_path)
			
			#if item[7]:
			#	itemSlot.get_node("Buy").text = str(int(item[8]))
			#elif item[6]:
			itemSlot.get_node("Buy").text = str(int(item[5]))
			
			itemSlot.get_node("Buy").connect("pressed", _on_buy_pressed.bind(2, item))
			if item[2] == true:
				itemSlot.get_node("Buy").disabled = true
				itemSlot.get_node("Buy").text = "Bought"
			shop_lance_grid.add_child(itemSlot)

func _on_equip_top_pressed() -> void:
	$Equipment.show()
	$Featured.hide()
	$Skills.hide()
	$Weapons.hide()
	$Costume.hide()
	for child in $ScrollContainer/VBoxContainer/Equipment.get_children():
		if child.name.begins_with("Equipment"):
			continue
		elif child.name.begins_with("EquipTop"):
			child.button_pressed = true
			continue
		child.button_pressed = false

	for child in $Equipment.get_children():
		if child.name.begins_with("Top"):
			child.show()
			continue
		child.hide()
	
	for child in $ScrollContainer/VBoxContainer/Costume.get_children():
		if child.name.begins_with("Costume"):
			continue
		child.button_pressed = false
	for child in $ScrollContainer/VBoxContainer/Skills.get_children():
		if child.name.begins_with("Skills"):
			continue
		child.button_pressed = false
	for child in $ScrollContainer/VBoxContainer/Weapons.get_children():
		if child.name.begins_with("Weapons"):
			continue
		child.button_pressed = false
	
	var shop_equip_top_grid = $Equipment/Top/ScrollContainer/GridContainer
	
	for child in shop_equip_top_grid.get_children():
		shop_equip_top_grid.remove_child(child)
		child.queue_free()
	
	for item in Global.saving_list[3]:
		if item[6] == true:
			var itemSlot = store_item_scene.instantiate()
			var textureRect_path = "res://Assets/testing.png" # testing use code
			#var icon_path = "res://Assets/"+item[0]+".png"
			
			if ResourceLoader.exists(textureRect_path):
				itemSlot.get_node("itemName").text = item[0]
				itemSlot.get_node("TextureRect").texture = load(textureRect_path)
				
				#.texture_normal = load(icon_path)
			else:
				print("Icon: " +item[0]+ " not found man, try check the asset")
			
			#var icon_path = "res://Assets/"+item[0]+".png"
			var icon_path = "res://Assets/stars.png"
			itemSlot.get_node("Buy").icon = load(icon_path)
			
			#if item[7]:
			#	itemSlot.get_node("Buy").text = str(int(item[8]))
			#elif item[6]:
			itemSlot.get_node("Buy").text = str(int(item[5]))
			
			itemSlot.get_node("Buy").connect("pressed", _on_buy_pressed.bind(3, item))
			if item[2] == true:
				itemSlot.get_node("Buy").disabled = true
				itemSlot.get_node("Buy").text = "Bought"
			shop_equip_top_grid.add_child(itemSlot)

func _on_equip_bottom_pressed() -> void:
	$Equipment.show()
	$Featured.hide()
	$Skills.hide()
	$Weapons.hide()
	$Costume.hide()
	for child in $ScrollContainer/VBoxContainer/Equipment.get_children():
		if child.name.begins_with("Equipment"):
			continue
		elif child.name.begins_with("EquipBottom"):
			child.button_pressed = true
			continue
		child.button_pressed = false

	for child in $Equipment.get_children():
		if child.name.begins_with("Bottom"):
			child.show()
			continue
		child.hide()
	
	for child in $ScrollContainer/VBoxContainer/Costume.get_children():
		if child.name.begins_with("Costume"):
			continue
		child.button_pressed = false
	for child in $ScrollContainer/VBoxContainer/Skills.get_children():
		if child.name.begins_with("Skills"):
			continue
		child.button_pressed = false
	for child in $ScrollContainer/VBoxContainer/Weapons.get_children():
		if child.name.begins_with("Weapons"):
			continue
		child.button_pressed = false
	
	
	var shop_equip_bottom_grid = $Equipment/Bottom/ScrollContainer/GridContainer
	
	for child in shop_equip_bottom_grid.get_children():
		shop_equip_bottom_grid.remove_child(child)
		child.queue_free()
	
	for item in Global.saving_list[4]:
		if item[6] == true:
			var itemSlot = store_item_scene.instantiate()
			var textureRect_path = "res://Assets/testing.png" # testing use code
			#var icon_path = "res://Assets/"+item[0]+".png"
			
			if ResourceLoader.exists(textureRect_path):
				itemSlot.get_node("itemName").text = item[0]
				itemSlot.get_node("TextureRect").texture = load(textureRect_path)
				
				#.texture_normal = load(icon_path)
			else:
				print("Icon: " +item[0]+ " not found man, try check the asset")
			
			#var icon_path = "res://Assets/"+item[0]+".png"
			var icon_path = "res://Assets/stars.png"
			itemSlot.get_node("Buy").icon = load(icon_path)
			
			#if item[7]:
			#	itemSlot.get_node("Buy").text = str(int(item[8]))
			#elif item[6]:
			itemSlot.get_node("Buy").text = str(int(item[5]))
			
			itemSlot.get_node("Buy").connect("pressed", _on_buy_pressed.bind(4, item))
			if item[2] == true:
				itemSlot.get_node("Buy").disabled = true
				itemSlot.get_node("Buy").text = "Bought"
			shop_equip_bottom_grid.add_child(itemSlot)
