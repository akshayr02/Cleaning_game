class_name EnemyStateDestroy extends EnemyState

#const PICKUP = preload("res://Items/item_pickup/item_pickup.tscn")

@export var anim_name : String = "Destroy"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category(("AI"))

@export_category("Item Drops")
#@export var drops: Array[DropData]

var _damage_position : Vector2
var _direction : Vector2
#var _animation_finished : bool = false

# What happens when we initalize this State?
func init() -> void:
	enemy.enemy_destroyed.connect(_on_enemy_destroyed)
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# What happens when the player enters this State?
func Enter() -> void:
	enemy.invulnerable = true
	_direction = enemy.global_position.direction_to(_damage_position)
	enemy.SetDirection(_direction)
	enemy.velocity = _direction * -knockback_speed
	#enemy.UpdateAnimation(anim_name)
	#enemy.animation_player.animation_finished.connect(_on_animation_finished)
	
	enemy.queue_free()
	disable_hurt_box()
	#drop_items()
	pass

# What happens when the player exits this State?
func Exit() -> void:
	pass
	
# What happens during the _process update in this State?
func Process( _delta : float) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null
	
# What happens during the _physics_process update in this State?
func Physics( _delta : float) -> EnemyState:
	return null
	
func _on_enemy_destroyed(hurtbox : HurtBox) -> void:
	_damage_position = hurtbox.global_position
	
	enemy_state_machine.ChangeState(self)

func _on_animation_finished( _a : String) -> void:
	enemy.queue_free()
	pass

func disable_hurt_box() -> void:
	var hurt_box: HurtBox = enemy.get_node_or_null("HurtBox")
	if hurt_box:
		hurt_box.monitoring = false

#func drop_items() -> void:
	#if drops.size() == 0:
		#return
	#for i in drops.size():
		#if drops[i] == null or drops[i].item == null:
			#continue
		#var drop_count: int = drops[i].get_drop_count()
		#for j in drop_count:
			#var drop: ItemPickup = PICKUP.instantiate() as ItemPickup
			#drop.item_data = drops[i].item
			#enemy.get_parent().call_deferred("add_child", drop)
			#drop.global_position = enemy.global_position
			#drop.velocity = enemy.velocity.rotated(randf_range(-1.5, 1.5)) * randf_range(0.9, 1.5)
