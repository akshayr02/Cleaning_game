class_name State_Death extends State

#@export var exhaust_audio: AudioStream
#@onready var audio: 

#What happens when we initialize this state?
func init() -> void:
	pass

# What happens when the player enters this State?
func Enter() -> void:
	player.animation_player.play("Death")
	#audio.stream = exhaust_audio
	#audio.play()
	
#	Triger Game Over UI
	#AudioManager.player_music(null)
	pass

# What happens when the player exits this State?
func Exit() -> void:
	pass
	
# What happens during the _process update in this State?
func Process( _delta : float) -> State:
	player.velocity = Vector2.ZERO
	return null
	
# What happens during the _physics_process update in this State?
func Physics( _delta : float) -> State:
	return null
	
# What happens with input events in this State?
func HandleInput( _event : InputEvent) -> State:
	return null
