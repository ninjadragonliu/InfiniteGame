extends CharacterBody2D

@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var animatation = $AnimationPlayer
@onready var explosion = $Explosion
var health = 1
var speed = 1
signal knocked_down

func _process(delta: float) -> void:
	if player.position.x - position.x > 0:
		position.x += speed
		animatation.play("running_ToRight")
		if position.x >= 279.0 and position.y == 110:
			position.y = 400.0
	elif player.position.x - position.x < 0:
		position.x -= speed
		animatation.play("running_ToLeft")
		if position.x <= 873.0 and position.y == 110:
			position.y = 400.0

func take_damage(damage : int):
	health -= damage
	if health <= 0:
		knocked_down.emit()
		queue_free()
	
