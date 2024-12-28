extends Node2D
class_name TileMapCoordinates

@export var tile_map_layer: TileMapLayer
@export var font_size: int = 7  # Set your desired font size here

func _ready():
	if tile_map_layer:
		var tile_size = tile_map_layer.tile_set.tile_size
		var used_cells = tile_map_layer.get_used_cells()
		for cell in used_cells:
			var label = Label.new()
			label.text = str(cell)
			label.position = tile_map_layer.map_to_local(cell) - Vector2(10, 5)
			label.add_theme_font_size_override("font_size", font_size)
			add_child(label)
