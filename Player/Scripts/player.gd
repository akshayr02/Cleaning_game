class_name Player extends CharacterBody2D

var direction : Vector2 = Vector2.ZERO
var last_direction : Vector2 = Vector2.RIGHT  # Default facing right
var current_direction_name := ""

@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer2
@onready var hitbox: Hitbox = $Hitbox
#@onready var effect_animation_player: AnimationPlayer = $EffectAnimationPlayer

signal DirectionChanged(new_direction_name: String)
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

	var raw_input = Vector2(
		Input.get_axis("Left", "Right"),
		Input.get_axis("Up", "Down")
	)
	# need to adjust the diagonal movements to be 22.5 degrees up or down from horizontal (instead of 45)
	var x = raw_input.x
	var y = raw_input.y

	# Diagonal correction: skew diagonals to use half vertical strength
	if x != 0 and y != 0:
		direction = Vector2(x, y * 0.5).normalized()
	else:
		direction = Vector2(x, y).normalized()

	if direction != Vector2.ZERO:
		var new_direction_name = get_direction_name(direction)

		if new_direction_name != current_direction_name:
			current_direction_name = new_direction_name
			DirectionChanged.emit(current_direction_name)

		last_direction = direction
		animation_player.play(new_direction_name)
	else:
		var standing_direction_name = get_direction_name(last_direction) + "-standing"
		if standing_direction_name != current_direction_name:
			current_direction_name = standing_direction_name
			DirectionChanged.emit(current_direction_name)

		animation_player.play(standing_direction_name)


func _physics_process(_delta: float) -> void:
	move_and_slide()
	
func SetDirection() -> bool:
	if direction == Vector2.ZERO:
		return false
	
	var direction_angle = direction.angle_to(Vector2.LEFT + Vector2.UP)
	var direction_id = (direction_angle+2)%45 - 1
	
	DirectionChanged.emit(direction_id)
	return true

func UpdateAnimation( state : String) -> void:
	#animation_player.play(state + "_" + AnimDirection())
	animation_player.play(state)
	pass
	
func _take_damage(hurtbox : HurtBox) -> void:
	if invulnerable:
		return
	if hp > 0:
		update_hp(-hurtbox.damage)
		player_damaged.emit(hurtbox)
	pass
	
func update_hp(delta : int) -> void:
	hp = clampi(hp + delta, 0, max_hp)
	#PlayerHud.update_hp(hp, max_hp)
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

# this is so fucking stupid but it works
func get_direction_name(dir: Vector2) -> String:
	var angle = dir.angle()
	var deg = rad_to_deg(angle)

	if deg < 0:
		deg += 360

	if deg >= 337.5 or deg < 22.5:
		return "right"
	elif deg < 67.5:
		return "down-right"
	elif deg < 112.5:
		return "down"
	elif deg < 157.5:
		return "down-left"
	elif deg < 202.5:
		return "left"
	elif deg < 247.5:
		return "up-left"
	elif deg < 292.5:
		return "up"
	else:
		return "up-right"



#func _physics_process(delta: float) -> void:
	#var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#
	#if direction:
		#self.velocity = direction * SPEED
	#else:
		#self.velocity = Vector2.ZERO
		#
	#move_and_slide()
	
	
