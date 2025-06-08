class_name Custom_Button extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Inside your TextureButton script or a connected script

func _on_TextureButton_pressed():
	self.modulate = Color(0.8, 0.8, 0.8)  # Darken on press

func _on_TextureButton_focused():
	self.modulate = Color(0.8, 0.8, 0.8)  # Darken on press

func _on_TextureButton_released():
	self.modulate = Color(1, 1, 1)  # Restore color
