class_name State_Attack extends State

var attacking : bool = false
@export var attack_time : float = 0.2

@export var attack_sound : AudioStream
@export_range(1,20,0.5) var decelerate_speed : float = 5.0

@onready var hurtbox: Hurtbox = $"../../Hurtbox"
#@onready var animation_player2: AnimationPlayer = $"../../Sprite2D/AnimationPlayer2"
@onready var idle: State = $"../Idle"
@onready var walk: State = $"../Walk"
#@onready var attack_anim: AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
#@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"

var timer : float = 1

# What happens when the player enters this State?
func Enter() -> void:
	print("in state attack")
	var player_dir
	print(player.direction)
	if player.direction.x == 1:
		if player.direction.y == 1:
			player_dir = "up-right" 
		elif player.direction.y == 0:
			player_dir = "right" 
		else:
			player_dir = "down-right"
	elif player.direction.x == 0:
		if player.direction.y == 1:
			player_dir = "up"
		else:
			player_dir = "down"
	else:	
		if player.direction.y == 1:
			player_dir = "up-left" 
		if player.direction.y == 0:
			player_dir = "left" 
		else:
			player_dir = "down-left"
	player.UpdateAnimation(player_dir + "-melee")
	#animation_player2.animation_finished.connect(EndAttack)
	
	#audio.stream = attack_sound
	#audio.pitch_scale = randf_range(0.9, 1.1)
	#audio.play()
	timer = 1;
	attacking = true
	await get_tree().create_timer(0.075).timeout
	if attacking:
		hurtbox.monitoring = true


# What happens when the player exits this State?
func Exit() -> void:
	#animation_player2.animation_finished.disconnect(EndAttack)
	attacking = false
	hurtbox.monitoring = false
	pass
	
# What happens during the _process update in this State?
func Process( _delta : float) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta


	timer -= _delta;
	if timer < 0:
		attacking = false
		
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null
	
# What happens during the _physics_process update in this State?
func Physics( _delta : float) -> State:
	return null
	
# What happens with input events in this State?
func HandleInput( _event : InputEvent) -> State:
	return null

func EndAttack(_newAnimName : String) -> void:
	attacking = false
