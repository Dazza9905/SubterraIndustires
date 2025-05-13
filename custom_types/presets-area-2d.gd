@tool
extends Area2D
class_name PresetsArea2D

enum CollisionType{
	BLOCKED,
	BLOCKED_BELT_ALLOW,
	IS_BELT,
	BLOCKED_WATER_ALLOW
}



@export var collision_type: CollisionType:
	set(new_type):
		collision_type = new_type
		update_coliders()

func _ready() -> void:
	update_coliders()

func update_coliders() -> void:
	if collision_type == CollisionType.BLOCKED:
		collision_layer = blocked_l
		collision_mask = blocked_m
		for child in get_children():
			if child is CollisionShape2D:
				(child as CollisionShape2D).debug_color = Color(1.0, 0.0, 0.0, 0.392)
	if collision_type == CollisionType.BLOCKED_BELT_ALLOW:
		collision_layer = blocked_belt_allow_l
		collision_mask = blocked_belt_allow_m
		for child in get_children():
			if child is CollisionShape2D:
				(child as CollisionShape2D).debug_color = Color(1.0, 0.427, 0.0, 0.392)
	if collision_type == CollisionType.IS_BELT:
		collision_layer = is_belt_l
		collision_mask = is_belt_m
		for child in get_children():
			if child is CollisionShape2D:
				(child as CollisionShape2D).debug_color = Color(1.0, 1.0, 0.0, 0.392)
	if collision_type == CollisionType.BLOCKED_WATER_ALLOW:
		collision_layer = blocked_water_allow_l
		collision_mask = blocked_water_allow_m
		for child in get_children():
			if child is CollisionShape2D:
				(child as CollisionShape2D).debug_color = Color(0.492, 0.478, 1.0, 0.392)
	name = str(CollisionType.keys()[collision_type]).to_pascal_case()

var blocked_l: int = 4352
var blocked_m: int = 61440

var blocked_belt_allow_l: int = 8448
var blocked_belt_allow_m: int = 45056

var is_belt_l: int = 540928
var is_belt_m: int = 53248 

var blocked_water_allow_l: int = 4352
var blocked_water_allow_m: int = 28672

#func _ready() -> void:
	#print("blocked: ", blocked_l, " ", blocked_m)
	#print("blocked belt allow: ", blocked_belt_allow_l, " ", blocked_belt_allow_m)
	#print("is belt: ", is_belt_l, " ", is_belt_m)
