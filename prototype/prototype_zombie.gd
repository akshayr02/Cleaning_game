extends CharacterBody2D

@export var move_speed: float = 100.0
var target: Node2D

func _physics_process(delta):
	if target:
		var direction = (target.global_position - global_position).normalized()
		velocity = direction * move_speed
		move_and_slide()
