extends Node2D

@export var zombie_char : PackedScene
@export var player : Node2D
@export var spawn_delay: float = 2.5

var timer: float = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	
	if timer >= spawn_delay:
		timer= 0;
		spawn_zombie();
	
func spawn_zombie():
	print("spawning zombie")
	if zombie_char:
		var zombie = zombie_char.instantiate()
		add_child(zombie)
		zombie.global_position = Vector2(100, 100)  # or wherever you want it
		zombie.target = player
