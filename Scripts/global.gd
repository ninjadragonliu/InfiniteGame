extends Node

var positions  = [
	Vector2(1, 110),
	Vector2(1, 400),
	Vector2(1150, 110),
	Vector2(1150, 400)
]

#region New Code Region
var max_health = 9
var health = max_health
var player_id
var player_name = "John Doe"
var vip_status = false
var intro_text = "Introduce yourself"
var coins = int(0)
var diamonds = int(0)
var max_score = 0
var last_login_date = ""

var new_attribute = true
var gm_mode = true
var money_mode = true
var loading_mode = false
#endregion

#region
# run to assign types
func _readyLists():
	for weapon in weapon_list_fist:
		weapon[1] = "fist"
	for weapon in weapon_list_sword:
		weapon[1] = "sword"
	for weapon in weapon_list_lance:
		weapon[1] = "lance"
	for top in top_list:
		top[1] = "top"
	for bottom in bottom_list:
		bottom[1] = "bottom"
	for active in active_skill_list:
		active[1] = "active"
	for passive in passive_skill_list:
		passive[1] = "passive"
	for costume in costume_hair_list:
		costume[1] = "costume_hair"
	for costume in costume_top_list:
		costume[1] = "costume_top"
	for costume in costume_bottom_list:
		costume[1] = "costume_bottom"
	if gm_mode:
		for i in range(10):
			for item in saving_list[i]:
				item[2] = true #own all items
	#print(saving_list)

func _update_for_new_items():
	var size_tracker = [[0], [0], [0], [0], [0], [0], [0], [0], [0], [0]] # will contain the items that has new attribute
	var temp_list = player_current_equip
	
	for i in range(10):
		temp_list = getLocalList_throughSavingIndex(i)
		while saving_list[i].size() < temp_list.size(): # check if item saved < item exist
			saving_list[i].append(temp_list[saving_list[i].size()]) # if so, add the newest item exist to saved item data list
			if temp_list[saving_list[i].size()-1].size() > size_tracker[i].size(): # check if total attribute of new item is > old item
				size_tracker[i] = temp_list[saving_list[i].size()-1] # track down the new item types
	
	if new_attribute:
		_update_for_new_attribute(size_tracker) # update the old item's attribute in same array to keep them at same size
	if money_mode:
		coins = 100000
		diamonds = 5000

func _update_for_new_attribute(size_tracker):
	var type_to_match = TYPE_NIL
	
	for i in range(1):
		for item in saving_list[i]:
			while item.size() < size_tracker[i].size():
				type_to_match = typeof(size_tracker[i][item.size()])
				match type_to_match:
					TYPE_STRING:
						item.append(String_Default)
					TYPE_BOOL:
						item.append(Bool_Default)
					TYPE_INT:
						item.append(Int_Default)
					TYPE_NIL:
						print("Error item: " + item[0] + " detected type NIL data as attribute. Check update_for_new_attribute")
					_:
						print("Error item: " + item[0] + " undetected type data as attribute. Check update_for_new_attribute")
			type_to_match = TYPE_NIL

func getLocalList_throughSavingIndex(count):
	match count:
		0:
			return weapon_list_fist
		1:
			return weapon_list_sword
		2:
			return weapon_list_lance
		3:
			return top_list
		4:
			return bottom_list
		5:
			return active_skill_list
		6:
			return passive_skill_list
		7:
			return costume_hair_list
		8:
			return costume_top_list
		9:
			return costume_bottom_list
		10:
			print("Warning: Do not use getLocalList_throughSavingIdex() for getting player_current_equip, local version of it should remain unchanged")

func getSavedList_throughLocalArray(array):
	match typeof(array[1]):
		TYPE_STRING:
			match array[1]:
				"fist":
					return saving_list[0]
				"sword":
					return saving_list[1]
				"lance":
					return saving_list[2]
				"top":
					return saving_list[3]
				"bottom":
					return saving_list[4]
				"active":
					return saving_list[5]
				"passive":
					return saving_list[6]
				"costume_hair":
					return saving_list[7]
				"costume_top":
					return saving_list[8]
				"costume_bottom":
					return saving_list[9]
				_:
					print("Error: Invalid type when using getSavedList_throughLocalArray()")
		TYPE_INT:
			var Accessing_player_current_equip_List = true
			for i in range(array.size()):
				if typeof(array[i]) != typeof(player_current_equip[i]):
					Accessing_player_current_equip_List = false
					break
			if Accessing_player_current_equip_List:
				return saving_list[10]

# [Item_Name, Item_Type	, Player_Owns, Equipped , Currency of Cost, Cost, Shop   , OnSalesShop  , Sales Price]
# [String	, String	, Boolean	 , Int		, String		  , Int	, Boolean, Boolean		, Int]

var String_Default = ""
var Bool_Default = false
var Int_Default = 0

# How to make event reward => give out the item as finish reward of event, then make sure Shop and on SalesShop => false 
var weapon_list_fist = [
	["Bare Fist","", true, 1, "", -1, false, false, -1],
	["Soldier Glove","", false, 0, "coin", 100, true, false, -1]
]
 
var weapon_list_sword = [
	["Wooden Sword","", true, 1, "", -1, false, false, -1],
	["Soldier Sword","", false, 0, "diamond", 5, true, true, 3]
]

var weapon_list_lance = [
	["Wooden Lance","", true, 1, "", -1, false, false, -1],
	["Soldier Lance","", false, 0, "diamond", 9, true, true, 5]
]
 
var top_list = [
	["Empty", "", true, 1, "", -1, false, false, -1],
	["Skin Armor", "", false, 0, "coin", 100, true, false, -1],
	["Leather Armor", "", false, 0, "coin", 500, true, false, -1]
]

var bottom_list = [
	["Empty", "", true, 1, "", -1, false, false, -1],
	["Skin Pants", "", false, 0, "coin", 100, true, false, -1],
	["Leather Pants", "", false, 0, "coin", 500, true, false, -1]
]

var active_skill_list = [
	["Empty", "", true, 1, "", -1, false, false, -1],
	["HP+3", "", false, 0, "coin", 1000, true, false, -1],
	["DamageReduction", "", false, 0, "coin", 2000, true, false, -1],
	["AttackBoost", "", false, 0, "coin", 1000, true, false, -1]
]

# passive skill index 3 (equip attribute) is special, 'Empty' can be set as 2 for 'Empty' may take up both slot
var passive_skill_list = [
	["Empty", "", true, 1, "", -1, false, false, -1],
	["MaxHP+2", "", false, 0, "coin", 300, true, false, -1]
]

var costume_hair_list = [
	["Empty", "", true, 1, "", -1, false, false, -1],
	["default", "", false, 0, "diamond", 10, true, false, -1],
	["paladin", "", false, 0, "diamond", 10, true, false, -1],
	["1", "", false, 0, "diamond", 20, true, false, -1]
]

var costume_top_list = [
	["Empty", "", true, 1, "", -1, false, false, -1],
	["default", "", false, 0, "diamond", 10, true, false, -1],
	["paladin", "", false, 0, "diamond", 10, true, false, -1],
	["3", "", false, 0, "diamond", 20, true, false, -1]
]

var costume_bottom_list = [
	["Empty", "", true, 1, "", -1, false, false, -1],
	["default", "", false, 0, "diamond", 10, true, false, -1],
	["paladin", "", false, 0, "diamond", 10, true, false, -1],
	["5", "", false, 0, "diamond", 20, true, false, -1]
]

# player current equip only stores the index of what is equiped [fist, sword, lance, top, bottom, active, passive1, passive2, costume_hair, costume_top, costume_bottom]
var player_current_equip = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

var saving_list = [weapon_list_fist, weapon_list_sword, weapon_list_lance, top_list, bottom_list, active_skill_list, passive_skill_list, costume_hair_list, costume_top_list, costume_bottom_list, player_current_equip]
#endregion

#region New Code Region
var level = 0
var mapNumber = 1
var cleared_levels: Array[int] = []
var levels_in_map = 11

var reduce_count = 0
var reduce_amount = 0
#endregion

#region New Code Region
var tutorial_cleared = true
var tutorial_levels = 5
var cleared_tutorial_levels: Array[int] = []
var tutorial_counter = 1
#endregion

#region New Code Region
var mapConstant_Amount = 20 * mapNumber
var growthFactor_Amount = 2
var amplitude_Amount = 7 * min(mapNumber, 100)
#endregion

#region New Code Region
var mapConstant_Speed = 1.2 * mapNumber
var growthFactor_Speed = 0.03
var amplitude_Speed = 0.1 * mapNumber
var was_data_loaded = false
#endregion
# reference weapon list in 1st code region
#region New Code Region shoppable items
# value = 1 - not sold, 0 is sold, -1 - unlimited value
var shop_costumes = [] # 3 types
var shop_skills = [] # 2 types
var shop_featured = [] # too many types
var coin_object = objectCreation.objectCreation("coins_110", "currency", -1)
#var shop_equipment = [coin_object] # 2 types 
var shop_equipment = {
	"currency": {
		"coins_110" : -1
	}
}
		
# weapon, armor, placeholder this is for adding to player bag
# (item_name, classification) - key : value
#var shop_weapons = [] # 3 types
var shop_weapons = {
	"sword": {
		"broadsword": 1
	}
}
#endregion


	
func _ready() -> void:
	player_id = generate_player_id()
	_readyLists()

func generate_player_id():
	var temp = ""
	for i in range(10):
		temp += str(randi_range(0, 9))
	return temp

func reset_health():
	Global.health = Global.max_health

func unlock_next_level():
	if level not in cleared_levels:
		cleared_levels.append(level)
		
func unlock_next_tutorial_level():
	if tutorial_counter not in cleared_tutorial_levels:
		cleared_tutorial_levels.append(tutorial_counter)

func save_game_data():
	var data = {
		"coins": coins,
		"level": level,
		"diamonds": diamonds,
		"player_id": player_id,
		"mapNumber": mapNumber,
		"player_name": player_name,
		"cleared_levels": cleared_levels,
		"tutorial_cleared": tutorial_cleared,
		"vip_status": vip_status,
		"intro_text": intro_text,
		"tutorial_counter": tutorial_counter,
		"cleared_tutorial_levels": cleared_tutorial_levels,
		"last_login_date": last_login_date,
		"saving_list": saving_list
	}
	SaveSystem.save_game(data)
	print("💾 Global data saved:", data)

func _notification(what):
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT \
	or what == NOTIFICATION_WM_CLOSE_REQUEST \
	or what == NOTIFICATION_WM_GO_BACK_REQUEST:
		save_game_data()

func load_data():
	if was_data_loaded:
		print("🟡 Data already loaded, skipping.")
		return
	var data := SaveSystem.load_game()
	if data:
		player_name = data.get("player_name", "John Doe")
		player_id = data.get("player_id", "")
		coins = data.get("coins", 0)
		diamonds = data.get("diamonds", 0)
		level = data.get("level", 1)
		mapNumber = data.get("mapNumber", 1)
		vip_status = data.get("vip_status", false)
		var loaded_array = data.get("cleared_levels", [])
		cleared_levels = []  # Clear any existing data just in case
		for i in loaded_array:
			cleared_levels.append(int(i))  # Ensure each item is cast to int
		intro_text = data.get("intro_text", "Introduce yourself")
		tutorial_cleared = data.get("tutorial_cleared", false)
		tutorial_counter = data.get("tutorial_counter", 1)
		var loaded_array2 = data.get("cleared_tutorial_levels", [])
		cleared_tutorial_levels = []
		for i in loaded_array2:
			cleared_tutorial_levels.append(int(i))
		was_data_loaded = true
		last_login_date = data.get("last_login_date", "")
		if(loading_mode):
			saving_list = data.get("saving_list", [])
		_update_for_new_items()
		print("✅ Global data loaded:", data)
