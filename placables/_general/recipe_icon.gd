@tool
extends Sprite2D

@export var bottom_texture: Texture

func _enter_tree() -> void:
	var bottom_sprite := Sprite2D.new()
	bottom_sprite.texture = bottom_texture
	
