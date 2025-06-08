class_name Level extends Node2D

var wave: int
var max_enemies: int
var is_enemies_stopped: bool = false
@export var wave_timer: int = 5


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerManager.set_as_parent(self)
	PlayerHud.reset()
	max_enemies = 2
	wave = 1
	PlayerHud.set_label_text(str(wave), "wave")
	PlayerHud.set_label_text(str(max_enemies), "enemies")
	PlayerManager.max_enemies_wave.emit(max_enemies)
	PlayerManager.no_more_enemies.connect(enemies_stopped)

func is_wave_completed() -> bool:
	var enemies = []
	for i in get_children():
		if i is Enemy:
			enemies.append(i)
	
	# check if there are any enemies
	if enemies.size() == 0:
		if is_enemies_stopped == true:
			return true
	return false
		
		
func _process(_delta):
	if is_wave_completed():
		get_tree().paused = true
		await get_tree().create_timer(wave_timer).timeout
		wave_reset()
		get_tree().paused = false
		

func wave_reset() -> void:
	print("wave_reset")
	wave += 1
	max_enemies *= 2
	PlayerHud.set_label_text(str(wave), "wave")
	PlayerHud.set_label_text(str(max_enemies), "enemies")
	is_enemies_stopped = false
	PlayerManager.count_reset.emit()
	PlayerManager.max_enemies_wave.emit(max_enemies)
	pass

func enemies_stopped() -> void:
	is_enemies_stopped = true
	pass
