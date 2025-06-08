class_name State_Walk extends State

@export var move_speed : float = 100.0
@onready var idle: State = $"../Idle"
@onready var attack: State_Attack = $"../Attack"

# What happens when the player enters this State?
func Enter() -> void:
	#player.UpdateAnimation("Walk")
	pass

# What happens when the player exits this State?
func Exit() -> void:
	pass
	
# What happens during the _process update in this State?
func Process( _delta : float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
		
	player.velocity = player.direction * move_speed
	
	#if player.SetDirection():
		#player.UpdateAnimation("Walk")
	return null
	
# What happens during the _physics_process update in this State?
func Physics( _delta : float) -> State:
	return null
	
# What happens with input events in this State?
func HandleInput( _event : InputEvent) -> State:
	if _event.is_action_pressed("Melee"):
		return attack
	if _event.is_action_pressed("Interact"):
		PlayerManager.interact_pressed.emit()
	return null
