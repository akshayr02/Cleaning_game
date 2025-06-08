class_name EnemySpawner extends Node2D

@export var enemy = preload("res://Enemies/Aggro_godot.tscn")
var spawn_points = []
#@onready var main = get_node("/root/Levels/Main")
@onready var playground: Level = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_children():
		if i is Marker2D:
			print(i.position)
			spawn_points.append(i)
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	var spawn = spawn_points[randi() % spawn_points.size()]
	var enemy = enemy.instantiate()
	enemy.global_position = spawn.global_position
	print(enemy.position)
	playground.add_child(enemy)
	#main.add_child((enemy))
	
	pass # Replace with function body.
