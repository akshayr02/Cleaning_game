class_name EnemySpawner extends Node2D

@export var enemy = preload("res://Enemies/Aggro_godot.tscn")
var spawn_points = []
var spawn_status: bool = true
var max_enemies: int
var enemies_count: int = 0
#@onready var main = get_node("/root/Levels/Main")
@onready var playground: Level = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerManager.max_enemies_wave.connect(enemy_max)
	for i in get_children():
		if i is Marker2D:
			print(i.position)
			spawn_points.append(i)
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	print(max_enemies)
	if enemies_count < max_enemies:
		var spawn = spawn_points[randi() % spawn_points.size()]
		var enemy = enemy.instantiate()
		enemy.global_position = spawn.global_position
		print(enemy.position)
		playground.add_child(enemy)
		enemies_count += 1
		#main.add_child((enemy))
	else:
		PlayerManager.no_more_enemies.emit()
		enemies_count = 0
	pass # Replace with function body.

func enemy_max(num) -> void:
	max_enemies = num
