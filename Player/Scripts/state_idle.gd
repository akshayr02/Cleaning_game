class_name State_Idle extends State

@onready var walk: State_Walk = $"../Walk"
@onready var attack: State_Attack = $"../Attack"
@onready var shooting: State_Shoot = $"../Shooting"


# What happens when the player enters this State?
func Enter() -> void:
	#player.UpdateAnimation("Idle")
	pass

# What happens when the player exits this State?
func Exit() -> void:
	pass
	
# What happens during the _process update in this State?
func Process( _delta : float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null
	
# What happens during the _physics_process update in this State?
func Physics( _delta : float) -> State:
	return null
	
# What happens with input events in this State?
func HandleInput( _event : InputEvent) -> State:
	if _event.is_action_pressed("Melee"):
		return attack
	if _event.is_action_pressed("Shoot"):
		return shooting
	if _event.is_action_pressed("Interact"):
		PlayerManager.interact_pressed.emit()
	return null
