extends AnimatedSprite2D


func _ready():
	play("explosion_default")
	await get_tree().create_timer(0.2).timeout
	queue_free()
