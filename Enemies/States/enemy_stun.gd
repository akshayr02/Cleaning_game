class_name EnemyStateStun extends EnemyState


@export var anim_name : String = "Stun"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0


@export_category(("AI"))
@export var next_state : EnemyState

var _damage_position : Vector2
var _direction : Vector2
var _animation_finished : bool = false

# What happens when we initalize this State?
func init() -> void:
	enemy.enemy_damaged.connect(_on_enemy_damaged)
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# What happens when the player enters this State?
func Enter() -> void:
	enemy.invulnerable = true
	_animation_finished = false
	print("in stun state")
	_direction = enemy.global_position.direction_to(_damage_position)
	enemy.SetDirection(_direction)
	enemy.velocity = _direction * -knockback_speed
	#enemy.UpdateAnimation(anim_name)
	#enemy.animation_player.animation_finished.connect(_on_animation_finished)
	await get_tree().create_timer(0.5).timeout
	_animation_finished = true
	pass

# What happens when the player exits this State?
func Exit() -> void:
	enemy.invulnerable = false
	#enemy.animation_player.animation_finished.disconnect(_on_animation_finished)
	pass
	
# What happens during the _process update in this State?
func Process( _delta : float) -> EnemyState:
	if _animation_finished == true:
		return next_state
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null
	
# What happens during the _physics_process update in this State?
func Physics( _delta : float) -> EnemyState:
	return null
	
func _on_enemy_damaged(_hurtbox : HurtBox) -> void:
	_damage_position = _hurtbox.global_position
	enemy_state_machine.ChangeState(self)

func _on_animation_finished( _a : String) -> void:
	_animation_finished = true
	pass
