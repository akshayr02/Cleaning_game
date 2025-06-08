class_name State_Stun extends State

@export var knockback_speed: float = 200.0
@onready var decelerate_speed: float = 10.0
@onready var invulnerable_duration: float = 1.0

var hurtbox : Hurtbox
var direction : Vector2

var next_state : State = null
@onready var idle: State_Idle = $"../Idle"
@onready var death: State_Death = $"../Death"

# What happens when the player enters this State?
func Enter() -> void:
	player.animation_player.animation_finished.connect(_animation_finished)
	direction = player.global_position.direction_to(hurtbox.global_position)
	player.velocity = direction * -knockback_speed
	
	#player.SetDirection(player.direction)
	player.UpdateAnimation("Stun")
	player.make_invulnerable(invulnerable_duration)
	player.effect_animation_player.play("Damaged")
	
	pass

# What happens when we initialize this state?
func init() -> void:
	player.player_damaged.connect(_player_damaged)

# What happens when the player exits this State?
func Exit() -> void:
	next_state = null
	player.animation_player.animation_finished.disconnect(_animation_finished)
	pass
	
# What happens during the _process update in this State?
func Process( _delta : float) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	return next_state
	
# What happens during the _physics_process update in this State?
func Physics( _delta : float) -> State:
	return null
	
func _player_damaged(_hurtbox : Hurtbox) -> void:
	hurtbox = _hurtbox
	if state_machine.current_state != death:
		state_machine.ChangeState(self)
	pass
	
func _animation_finished(_a : String) -> void:
	next_state = idle
	if player.hp <= 0:
		next_state = death
	pass
