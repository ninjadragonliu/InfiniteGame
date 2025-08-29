extends Control

@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var enemies = $Enemies
@onready var animation = player.get_node("AnimationPlayer")
@export var clear_screen : PackedScene

var enemy_in_range_left = []
var enemy_in_range_right = []
var level_cleared = false
var enemies_remaining
var score = 0

func _ready() -> void:
	enemies_remaining = enemies.enemies_amount
	$Health.max_value = Global.max_health
	# Connect player's signal to decrease enemy count
	player.take_damaged.connect(_on_player_damaged)
	enemies.enemy_down.connect(add_point)
	
	var timer = Timer.new()
	timer.wait_time = 2.0  # 每 2 秒生成一个敌人
	timer.autostart = true
	timer.one_shot = false
	add_child(timer)

	timer.timeout.connect(enemies.spawn_enemy)
	
	if Global.active_skill_list[Global.saving_list[10][5]][0] == "Empty":
		$Skills.hide()
	
func _process(delta: float) -> void:
	$Health/Label.text = str(Global.health) + "/" + str(Global.max_health)
	#$EnemiesRemaining/Label.text = str(enemies_remaining)
	$Score/Label.text = str(score)
	$Health.value = Global.health
	
func _on_player_damaged():
	enemies_remaining -= 1  # Decrease enemy count when player is hit
	#player_damaged = true
	if enemies_remaining == 0:
		clear_level()
	
func clear_level():
	$EnemiesRemaining/Label.text = str(enemies_remaining)
	if clear_screen:
		var popup = clear_screen.instantiate()
		var clear_label = popup.get_node("LevelCompleted")
		clear_label.text = "Level " + str(Global.level) + " Completed"
		get_tree().current_scene.add_child(popup)
		Global.unlock_next_level()  # Mark this level as cleared
		Global.save_game_data()
		popup.show()
		
		# Pause the game
		get_tree().paused = true

		# Allow the game over screen to function while paused
		#popup.process_mode = Node.PROCESS_MODE_ALWAYS

func clear_tutorial_level():
	$EnemiesRemaining.text = "Enemies Remaining: " + str(enemies_remaining)
	if clear_screen:
		var popup = clear_screen.instantiate()
		var clear_label = popup.get_node("LevelCompleted")
		clear_label.text = "Level " + str(Global.tutorial_counter) + " Completed"
		get_tree().current_scene.add_child(popup)
		Global.unlock_next_tutorial_level()
		Global.save_game_data()
		popup.show()
		
		# Pause the game
		get_tree().paused = true

		# Allow the game over screen to function while paused
		#popup.process_mode = Node.PROCESS_MODE_ALWAYS

func _on_left_pressed() -> void:
	if enemy_in_range_left:
		for enemy in enemy_in_range_left:
			player.attack(enemy)
			enemy_in_range_left.erase(enemy)
			player._animation_resource_visibility(2)
			animation.play("Attack_Left")

	else:
		player._animation_resource_visibility(2)
		animation.play("Attack_Left")
#	if animation.animation_finished:
#		player._animation_resource_visibility(1)
#		animation.play("Idle_Left")


func _on_right_pressed() -> void:
	if enemy_in_range_right:
		for enemy in enemy_in_range_right:
			player.attack(enemy)
			enemy_in_range_right.erase(enemy)
			#attack_right.emit()
			player._animation_resource_visibility(2)
			animation.play("Attack_Right")

	else:
		#attack_right.emit()
		player._animation_resource_visibility(2)
		animation.play("Attack_Right")
#	if animation.animation_finished:
#		player._animation_resource_visibility(1)
#		animation.play("Idle_Right")

func _on_line_left_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy") or body.is_in_group("boss"):
		enemy_in_range_left.append(body)

func _on_line_right_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy") or body.is_in_group("boss"):
		enemy_in_range_right.append(body)

func _on_skills_pressed() -> void:
	print("Skill actived")
	$Skill_effect.calling_skill()

func _on_skill_timer_timerout():
	#player.damage = player.damage_normal
	player.damage_resistance = player.damage_resistance_normal
	
func _on_fist_pressed() -> void:
	player.change_weapon()
	print("Weapon 1 selected")
	

func _on_sword_pressed() -> void:
	player.change_weapon()
	print("Weapon 2 selected")


func _on_lance_pressed() -> void:
	player.change_weapon()
	print("Weapon 3 selected")

func add_point():
	score += 1
