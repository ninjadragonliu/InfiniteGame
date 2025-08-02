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
	change_weapon()
	left_button = get_tree().current_scene.get_node("Left")
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

func change_weapon():
	var resource_path = load("res://Assets/Animation/MainCharacter/"+Global.saving_list[Global.get_player_weapon_type_id()][Global.saving_list[7][1]][0]+".png")
	
	$Body.texture = resource_path
	$Pants.texture = resource_path
	$Clothe.texture = resource_path
	$Hair.texture = resource_path
	$Weapon.texture = resource_path

func _on_animation_player_animation_started(anim_name: StringName) -> void:
	left_button.disabled = true
	right_button.disabled = true
	#print("buttons disabled")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	left_button.disabled = false
	right_button.disabled = false
	#print("buttons enabled")
	
