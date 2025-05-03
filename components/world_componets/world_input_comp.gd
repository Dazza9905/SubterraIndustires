@tool
extends Node2D
class_name WorldInputComp


@export var io_comp: IOComponent:
	set(new_io):
		io_comp = new_io
		update()


func update() -> void:
	var texture: Texture2D = preload("uid://ckqb7yvo30sbi")
	
	var shadow: Sprite2D = Sprite2D.new()
	var highlight: Sprite2D = Sprite2D.new()
	
	highlight.z_index = 4
	
	shadow.texture = AtlasTexture.new()
	highlight.texture = AtlasTexture.new()
	
	self.add_child(shadow)
	self.add_child(highlight)
	
	
	
	(shadow.texture as AtlasTexture).atlas = texture
	(highlight.texture as AtlasTexture).atlas = texture
	var column : int = io_comp.base_side
	var row : int = 0
	if io_comp is OutputComponent:
		row = 1
	
	(shadow.texture as AtlasTexture).region = Rect2(column * 16, 2 * 16, 16, 16)
	(highlight.texture as AtlasTexture).region = Rect2(column * 16, row * 16, 16, 16)
	
	var vec_side: Vector2i
	match io_comp.base_side:
		SIDE_LEFT:
			vec_side = Vector2(-1, 0)
		SIDE_TOP:
			vec_side = Vector2(0, -1)
		SIDE_RIGHT:
			vec_side = Vector2(1, 0)
		SIDE_BOTTOM:
			vec_side = Vector2(0, 1)
	
	position = (vec_side + io_comp.cell_offset) * 16
	
