class_name Camera extends Camera2D

@onready var tilemap: TileMapLayer = $"../../Test_tilemap"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var used_rect = tilemap.get_used_rect() # The tile rectangle in grid space
	var tile_size = Vector2i(32, 16)

	var bounds : Array[ Vector2 ] = []

	bounds.append(
		tilemap.map_to_local(used_rect.position - Vector2i(1,1)) #gives left corner coords (one left of it)
	)
	bounds.append(
		tilemap.map_to_local(used_rect.end) #gives right corner coords
	)
	bounds.append(
		tilemap.map_to_local(used_rect.position + Vector2i(used_rect.size[0], 0 )) #gives top corner coords
	)
	bounds.append(
		tilemap.map_to_local(used_rect.end - Vector2i(used_rect.size[0], 0 )) #gives bottom corner coords
	)
	
	if bounds == []:
		return
	limit_left = int( bounds[0].x )
	limit_right = int( bounds[1].x )
	limit_top = int(bounds[2].y)
	limit_bottom = int( bounds[3].y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
