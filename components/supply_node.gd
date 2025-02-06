extends Node
class_name SupplyNode

@export var source_item: Item
@export var sprite: Sprite2D

func _ready() -> void:
	(sprite.texture as AtlasTexture).region.position.y += 16*(Globals.get_level_num())
