extends CanvasLayer

var hearts : Array[HeartGUI] = []

@onready var h_flow_container: HFlowContainer = $Control/HFlowContainer
@onready var game_over: Control = $Control/GameOver
@onready var retry: TextureButton = $Control/GameOver/VBoxContainer/Retry
@onready var main_menu_button: TextureButton = $Control/GameOver/VBoxContainer/MainMenu
@onready var animation_player: AnimationPlayer = $Control/AnimationPlayer
@onready var wave_label: Label = $Control/Bot_panel/Wave_label
@onready var enemies_label: Label = $Control/Bot_panel/Enemies_label
@onready var start: Custom_Button = $Control/MainMenu/Start
@onready var main_menu: Control = $Control/MainMenu
@onready var fade_to_black_all: ColorRect = $Control/FadeToBlackAll
@onready var audio_main_menu: AudioStreamPlayer2D = $AudioMainMenu
@onready var audio_game: AudioStreamPlayer2D = $AudioGame
@onready var audio_game_over: AudioStreamPlayer2D = $AudioGameOver


var is_paused : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset()
	show_main_menu()
	#hide_game_over_screen()
	for child in h_flow_container.get_children():
		if child is HeartGUI:
			hearts.append(child)
			child.visible = false	
	

func reset() -> void:
	#animation_player.stop()
	#animation_player.seek(0, true)
	# Disconnect buttons to avoid duplicate connections
	if retry.pressed.is_connected(load_game):
		retry.pressed.disconnect(load_game)
	if main_menu_button.pressed.is_connected(load_main_menu):
		main_menu_button.pressed.disconnect(load_main_menu)
	if start.pressed.is_connected(start_game):
		start.pressed.disconnect(start_game)
	# Reconnect
	retry.pressed.connect(load_game)
	main_menu_button.pressed.connect(load_main_menu)
	start.pressed.connect(start_game)
	
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
	audio_game.stop()
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
	await fade_all_to_black()
	hide_game_over_screen()
	get_tree().reload_current_scene()
	await fade_all_from_black()
	audio_main_menu.stop()	
	audio_game.play()	
	pass

func load_main_menu() -> void:
	await fade_all_to_black()
	hide_game_over_screen()
	show_main_menu()
	audio_main_menu.play()
	await fade_all_from_black()
	pass

func show_main_menu() -> void:
	main_menu.visible = true
	audio_main_menu.play()
	animation_player.play("Show_main_menu")
	await animation_player.animation_finished
	game_over.mouse_filter = Control.MOUSE_FILTER_STOP
	get_tree().paused = true
	start.grab_focus()

func hide_main_menu() -> void:
	main_menu.visible = false
	
func start_game() -> void:
	await fade_all_to_black()
	hide_main_menu()
	get_tree().paused = false
	reset()
	get_tree().reload_current_scene()
	await fade_all_from_black()
	audio_main_menu.stop()
	audio_game.play()	
	pass

func fade_all_to_black() -> bool:
	animation_player.play("Fade_all_to_black")
	await animation_player.animation_finished
	return true

func fade_all_from_black() -> bool:
	animation_player.play("Fade_all_from_black")
	await animation_player.animation_finished
	return true

func set_label_text(text, label_name) -> void:
	if label_name == "wave":
		wave_label.text = text
	elif label_name == "enemies":
		enemies_label.text = text
	pass
