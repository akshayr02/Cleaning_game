class_name EnemyStateChase2 extends EnemyState

@export var anim_name : String = "Chase2"
@export var chase_speed : float = 40.0

@export_category(("AI"))
@export var turn_rate: float = 0.25
@export var state_aggro_duration : float = 0.5

var _direction : Vector2

# What happens when we initalize this State?
func init() -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# What happens when the player enters this State?
func Enter() -> void:
	print("in chase state")
	pass

# What happens when the player exits this State?
func Exit() -> void:
	pass
	
# What happens during the _process update in this State?
func Process( _delta : float) -> EnemyState:
	var new_dir: Vector2 = enemy.global_position.direction_to(PlayerManager.player.global_position)
	_direction = lerp(_direction, new_dir, turn_rate)
	enemy.velocity = _direction * chase_speed
	return null
	
# What happens during the _physics_process update in this State?
func Physics( _delta : float) -> EnemyState:
	return null

#func _on_player_enter() -> void:
	##if enemy_state_machine.current_state is EnemyStateStun:
		##return
	#print(self)
	#enemy_state_machine.ChangeState(self)
	#pass
