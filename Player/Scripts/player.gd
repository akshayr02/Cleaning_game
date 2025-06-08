class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer2
@onready var hitbox: Hitbox = $Hitbox
#@onready var effect_animation_player: AnimationPlayer = $EffectAnimationPlayer

signal DirectionChanged(new_direction: Vector2)
signal player_damaged(hurtbox : HurtBox)

var invulnerable : bool = false
var hp : int = 6
var max_hp : int = 6


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerManager.player = self
	state_machine.Initialize(self)
	hitbox.Damaged.connect(_take_damage)
	update_hp(99)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	#direction.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	
	direction = Vector2(
		Input.get_axis("Left", "Right"),
		Input.get_axis("Up", "Down")
		).normalized()
	pass

func _physics_process(_delta: float) -> void:
	move_and_slide()
	
	
func SetDirection() -> bool:
	if direction == Vector2.ZERO:
		return false
	
	var direction_id : int = int(round((direction + cardinal_direction * 0.1).angle()/TAU * DIR_4.size()))
	var new_dir = DIR_4[direction_id]	
	
	if new_dir == cardinal_direction:
		return false
	cardinal_direction = new_dir
	
	DirectionChanged.emit(new_dir)
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

func UpdateAnimation( state : String) -> void:
	#animation_player.play(state + "_" + AnimDirection())
	animation_player.play(state)
	pass
	
func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"

func _take_damage(hurtbox : HurtBox) -> void:
	if invulnerable:
		return
	if hp > 0:
		update_hp(-hurtbox.damage)
		player_damaged.emit(hurtbox)
	pass
	
func update_hp(delta : int) -> void:
	hp = clampi(hp + delta, 0, max_hp)
	PlayerHud.update_hp(hp, max_hp)
	pass
	
func make_invulnerable(_duration : float = 1.0) -> void:
	invulnerable = true
	hitbox.monitoring = false
	
	await get_tree().create_timer(_duration).timeout
	
	invulnerable = false
	hitbox.monitoring = true
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("test"):
		update_hp(-99)
		player_damaged.emit($Hurtbox)
	pass

#func _physics_process(delta: float) -> void:
	#var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#
	#if direction:
		#self.velocity = direction * SPEED
	#else:
		#self.velocity = Vector2.ZERO
		#
	#move_and_slide()
	
	
