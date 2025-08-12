extends Node

@onready var player = load("res://Scripts/player.gd")

func calling_skill():
	match Global.active_skill_list[Global.saving_list[10][5]][0]:
		"HP+3":
			if Global.health + 3 > Global.max_health:
				Global.health = Global.max_health
			else:
				Global.health += 3
		"DamageReduction":
			Global.reduce_count = 3
			Global.reduce_amount = 2
		"AttackBoost":
			player.damage += 2
	
