extends CanvasLayer

var hearts : Array[HeartGUI] = []

@onready var h_flow_container: HFlowContainer = $Control/HFlowContainer
@onready var game_over: Control = $Control/GameOver
@onready var retry: Button = $Control/GameOver/ColorRect/VBoxContainer/Retry
@onready var main_menu: Button = $Control/GameOver/ColorRect/VBoxContainer/MainMenu
@onready var animation_player: AnimationPlayer = $Control/GameOver/AnimationPlayer


var is_paused : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#PauseMenu.shown.connect(hide_player_hud)
	
	for child in h_flow_container.get_children():
		if child is HeartGUI:
			hearts.append(child)
			child.visible = false
	#PauseMenu.hidden.connect(show_player_hud)
	#reset()
	
	pass # Replace with function body.
	
#func show_player_hud() -> void:
	#color_rect.visible = true
	#label.visible = true
	#
#func hide_player_hud() -> void:
	#color_rect.visible = false
	#label.visible = false

func reset() -> void:
	animation_player.stop()
	animation_player.seek(0, true)
	hide_game_over_screen()
	# Disconnect buttons to avoid duplicate connections
	if retry.pressed.is_connected(load_game):
		retry.pressed.disconnect(load_game)
	if main_menu.pressed.is_connected(load_main_menu):
		main_menu.pressed.disconnect(load_main_menu)
	# Reconnect
	retry.pressed.connect(load_game)
	main_menu.pressed.connect(load_main_menu)
	
func update_hp(_hp : int, _max_hp : int) -> void:
	update_max_hp(_max_hp)
	for i in _max_hp:
		update_heart(i, _hp)
	pass

func update_heart(_index : int, _hp : int) -> void:
	var _value : int = clampi(_hp - _index * 2, 0, 2)
	hearts[_index].value = _value
	pass
	
func update_max_hp(_max_hp : int) -> void:
	var _heart_count : int = roundi(_max_hp * 0.5)
	for i in hearts.size():
		if i < _heart_count:
			hearts[i].visible = true
		else:
			hearts[i].visible = false
	pass

func show_game_over_screen() -> void:
	game_over.visible = true
	game_over.mouse_filter = Control.MOUSE_FILTER_STOP

	animation_player.play("Show_game_over")
	await animation_player.animation_finished
	retry.grab_focus()
	pass

func hide_game_over_screen() -> void:
	game_over.visible = false
	game_over.mouse_filter = Control.MOUSE_FILTER_IGNORE
	game_over.modulate = Color(1,1,1,0)
	pass

func load_game() -> void:
	await fade_to_black()
	get_tree().reload_current_scene()
	hide_game_over_screen()
	pass

func load_main_menu() -> void:
	await fade_to_black()
	#load title screen
	pass

func fade_to_black() -> bool:
	animation_player.play("Fade_to_black")
	await animation_player.animation_finished
	return true
