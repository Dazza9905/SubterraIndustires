@tool
extends Area2D
class_name PresetsArea2D

enum CollisionType{
	BLOCKED,
	BLOCKED_BELT_ALLOW,
	IS_BELT
}

@export var collision_type: CollisionType:
	set(new_type):
		collision_type = new_type
		if new_type == CollisionType.BLOCKED:
			collision_layer = blocked_l
			collision_mask = blocked_m
		if new_type == CollisionType.BLOCKED_BELT_ALLOW:
			collision_layer = blocked_belt_allow_l
			collision_mask = blocked_belt_allow_m
		if new_type == CollisionType.IS_BELT:
			collision_layer = is_belt_l
			collision_mask = is_belt_m
		name = str(CollisionType.keys()[collision_type]).to_pascal_case()


var blocked_l: int = 4352
var blocked_m: int = 28672

var blocked_belt_allow_l: int = 8448
var blocked_belt_allow_m: int = 12288

var is_belt_l: int = 540928
var is_belt_m: int = 20480 


#func _ready() -> void:
	#print("blocked: ", blocked_l, " ", blocked_m)
	#print("blocked belt allow: ", blocked_belt_allow_l, " ", blocked_belt_allow_m)
	#print("is belt: ", is_belt_l, " ", is_belt_m)
