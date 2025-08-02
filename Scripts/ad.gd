extends Node

@onready var admob = Engine.get_singleton("AdMob")

func _ready():
	if admob:
		print("AdMob plugin loaded")
		admob.init("ca-app-pub-3940256099942544~3347511713")  # Test App ID
		admob.load_rewarded_video("ca-app-pub-3940256099942544/5224354917")  # Test Rewarded ID

func show_rewarded_ad():
	if admob.is_rewarded_video_loaded():
		admob.show_rewarded_video()
	else:
		print("Rewarded video not loaded yet")

func _on_admob_rewarded(reward_type: String, reward_amount: int):
	print("User earned reward: %s x %d" % [reward_type, reward_amount])
	get_node("/root/GameManager").add_gold(100)  # Replace with your own reward logic
