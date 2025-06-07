extends CanvasLayer

##var hearts : Array[HeartGUI] = []
#
#@onready var color_rect: ColorRect = $Control/ColorRect
#@onready var label: Label = $Control/Label
#@onready var h_flow_container: HFlowContainer = $Control/HFlowContainer
#
#
#var is_paused : bool = false
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#PauseMenu.shown.connect(hide_player_hud)
	#
	#for child in h_flow_container.get_children():
		#if child is HeartGUI:
			#hearts.append(child)
			#child.visible = false
	#PauseMenu.hidden.connect(show_player_hud)
	#pass # Replace with function body.
	#
#func show_player_hud() -> void:
	#color_rect.visible = true
	#label.visible = true
	#
#func hide_player_hud() -> void:
	#color_rect.visible = false
	#label.visible = false
	#
#func update_hp(_hp : int, _max_hp : int) -> void:
	#update_max_hp(_max_hp)
	#for i in _max_hp:
		#update_heart(i, _hp)
	#pass
#
#func update_heart(_index : int, _hp : int) -> void:
	#var _value : int = clampi(_hp - _index * 2, 0, 2)
	#hearts[_index].value = _value
	#pass
	#
#func update_max_hp(_max_hp : int) -> void:
	#var _heart_count : int = roundi(_max_hp * 0.5)
	#for i in hearts.size():
		#if i < _heart_count:
			#hearts[i].visible = true
		#else:
			#hearts[i].visible = false
	#pass
