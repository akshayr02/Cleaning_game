class_name Camera extends Camera2D

@onready var tilemap: TileMapLayer = $"../../Test_tilemap"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var used_rect = tilemap.get_used_rect() # The tile rectangle in grid space
	#var tile_size = tilemap.tile_set.tile_size
	var tile_size = 32
	#
	#var top_left = tilemap.map_to_local(used_rect.position)
	#var bottom_right = tilemap.map_to_local(used_rect.position + used_rect.size)
	#print(used_rect.position)
	#print(used_rect.size)
#
	## Add tile size to bottom_right in case tilemap doesn't fully align
	#bottom_right += Vector2(tile_size.x, tile_size.y)
	
	var bounds : Array[ Vector2 ] = []
	bounds.append(
		Vector2( used_rect.position * tile_size ) + tilemap.position
	)
	bounds.append(
		Vector2( used_rect.end * tile_size/2 ) + tilemap.position
	)
	print(bounds)
	
	if bounds == []:
		return
	limit_left = int( bounds[0].x )
	limit_top = int( bounds[0].y )
	limit_right = int( bounds[1].x )
	limit_bottom = int( bounds[1].y )

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
