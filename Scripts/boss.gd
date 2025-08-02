extends CharacterBody2D

@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var animatation = $AnimationPlayer
var max_health = 5
var health = max_health
var attack = 3
var speed = 1
var spawn_line = 30
signal taken_down

func _process(delta: float) -> void:
	$Health.max_value = max_health
	$Health.value = health
	$Health/Label.text = str(health) + "/" + str(max_health)
	if player.position.x - position.x > 0:
		position.x += speed
		#animatation.play("running_ToRight")
		if position.x >= 279.0 and position.y == 110:
			position.y = 400.0
	elif player.position.x - position.x < 0:
		position.x -= speed
		#animatation.play("running_ToLeft")
		if position.x <= 873.0 and position.y == 110:
			position.y = 400.0

func take_damage(damage : int):
	health -= damage
	position = Global.positions[randi() % Global.positions.size()]
	if health <= 0:
		taken_down.emit()
		queue_free()
