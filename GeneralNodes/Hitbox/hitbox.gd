class_name Hitbox extends Area2D

signal Damaged( hurtbox : HurtBox )

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
	
func TakeDamage( hurtbox : HurtBox) -> void:
	Damaged.emit(hurtbox)
