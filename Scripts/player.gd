extends CharacterBody2D

@onready var game_over : PackedScene = load("res://nodes/game_over.tscn")
signal take_damaged
signal boss_hit_player
var left_button
var right_button
static var damage_normal = 1
static var damage : int = damage_normal
static var damage_resistance_normal = 0
static var damage_resistance : int = 0


func _ready():
	#change_weapon()
	if get_tree().current_scene.has_node("Left"):
		left_button = get_tree().current_scene.get_node("Left")
	if get_tree().current_scene.has_node("Right"):
		right_button = get_tree().current_scene.get_node("Right")

func attack(body : Node2D):
	body.take_damage(damage)

func take_damage(damage: int):
	if Global.reduce_count > 0:
		damage = max(0, damage-Global.reduce_amount)
		Global.reduce_count-=1
	else:
		Global.reduce_amount = 0
	Global.health -= damage
	if Global.health <= 0:
		var popup = game_over.instantiate()
		get_tree().current_scene.add_child(popup)
		popup.show()

		# Pause the game
		get_tree().paused = true

		# Allow the game over screen to function while paused
		#popup.process_mode = Node.PROCESS_MODE_ALWAYS

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("boss"):
		take_damage(body.attack - damage_resistance)
		var current_scene = get_tree().current_scene
		if current_scene:
			# Remove from left array if it's in range
			if current_scene.enemy_in_range_left.has(body):
				current_scene.enemy_in_range_left.erase(body)
				#print("✅ Removed enemy from left array:", body)

			# Remove from right array if it's in range
			if current_scene.enemy_in_range_right.has(body):
				current_scene.enemy_in_range_right.erase(body)
				#print("✅ Removed enemy from right array:", body)
		body.position = Global.positions[randi() % Global.positions.size()]
		boss_hit_player.emit()

	if body.is_in_group("enemy"):
		var explosion = preload("res://nodes/explosion.tscn").instantiate()
		explosion.position = body.position
		var current_scene = get_tree().current_scene
		take_damage(1 - damage_resistance)
		current_scene.add_child(explosion)
		
		if current_scene:
			# Remove from left array if it's in range
			if current_scene.enemy_in_range_left.has(body):
				current_scene.enemy_in_range_left.erase(body)
				#print("✅ Removed enemy from left array:", body)

			# Remove from right array if it's in range
			if current_scene.enemy_in_range_right.has(body):
				current_scene.enemy_in_range_right.erase(body)
				#print("✅ Removed enemy from right array:", body)
				
		body.queue_free()
		take_damaged.emit()

func update_animation(index: int = 3):#index 3 is ignored, index 0 means it is fist animation, 1 is sword, 2 is lance
	var idle_path
	var idle_weapon_path
	var atk_path
	var atk_weapon_path
	
	if index == 3:
		$Body_idle.show()
		$Hair_idle.show()
		$Clothe_idle.show()
		$Pants_idle.show()
		$Weapon_idle.show()
		
		$Body_atk.hide()
		$Hair_atk.hide()
		$Clothe_atk.hide()
		$Pants_atk.hide()
		$Weapon_atk.hide()
		$Effect_atk.hide()
	else:
		$Body_idle.hide()
		$Hair_idle.hide()
		$Clothe_idle.hide()
		$Pants_idle.hide()
		$Weapon_idle.hide()
		
		$Body_atk.show()
		$Hair_atk.show()
		$Clothe_atk.show()
		$Pants_atk.show()
		$Weapon_atk.show()
		$Effect_atk.show()
	
	for costume_part_index in range(7,10):
		print("res://Assets/Animation/MainCharacter/"+Global.saving_list[costume_part_index][Global.saving_list[10][costume_part_index+1]][0]+"/Idle.png")
		idle_path = load("res://Assets/Animation/MainCharacter/"+Global.saving_list[costume_part_index][Global.saving_list[10][costume_part_index+1]][0]+"/Idle.png")
		
		match costume_part_index:
			7:
				$Body_idle.texture = idle_path
				$Hair_idle.texture = idle_path
			8:
				$Clothe_idle.texture = idle_path
			9:
				$Pants_idle.texture = idle_path
		
		if(index != 3):
			var type = ""
			match(index):
				0:
					type = "/Fist.png"
				1:
					type = "/Sword.png"
				2:
					type = "/Lance.png"
			print("------------")
			print("res://Assets/Animation/MainCharacter/"+Global.saving_list[costume_part_index][Global.saving_list[10][costume_part_index+1]][0]+type)
			atk_path = load("res://Assets/Animation/MainCharacter/"+Global.saving_list[costume_part_index][Global.saving_list[10][costume_part_index+1]][0]+type)
			
			match costume_part_index:
				7:
					$Body_atk.texture = atk_path
					$Hair_atk.texture = atk_path
				8:
					$Clothe_atk.texture = atk_path
				9:
					$Pants_atk.texture = atk_path
	
	if(index != 3):
		print("------------")
		print("res://Assets/Animation/MainCharacter/weapon_and_effect/Idle_"+Global.saving_list[index][Global.saving_list[10][index]][0].replace(" ", "_")+".png")
		idle_weapon_path = load("res://Assets/Animation/MainCharacter/Weapon_and_Effect/Idle_"+Global.saving_list[index][Global.saving_list[10][index]][0].replace(" ", "_")+".png")
		$Weapon_idle.texture = idle_weapon_path
		
		print("res://Assets/Animation/MainCharacter/weapon_and_effect/"+Global.saving_list[index][Global.saving_list[10][index]][0].replace(" ", "_")+".png")
		atk_weapon_path = load("res://Assets/Animation/MainCharacter/Weapon_and_Effect/"+Global.saving_list[index][Global.saving_list[10][index]][0].replace(" ", "_")+".png")
		$Weapon_atk.texture = atk_weapon_path
		$Effect_atk.texture = atk_weapon_path

func _on_animation_player_animation_started(anim_name: StringName) -> void:
	left_button.disabled = true
	right_button.disabled = true
	#print("buttons disabled")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	left_button.disabled = false
	right_button.disabled = false
	#print("buttons enabled")


#region animation data
func play_animation_playerAtk():
	pass
func play_animation_playerIdle():
	pass
func play_animation_playerIdle_loop():
	pass
# Idle has 7 frames and attack has 10 frames
#endregion
