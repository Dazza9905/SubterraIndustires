@tool
extends Node
class_name TextureRotationManager

@export var parent_GO: GridObject
@export var GO_texture: Texture
@export var building_textures: Dictionary[]
#(((360 + int(parent_GO.rotation_degrees)) % 360) / 90)) % 4
