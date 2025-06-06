class_name Player extends CharacterBody2D


const SPEED = 100


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if direction:
		print(direction)
		self.velocity = direction * SPEED
	else:
		self.velocity = Vector2.ZERO
		
	move_and_slide()
