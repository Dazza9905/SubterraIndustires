@tool
extends AnimatedSprite2D
class_name AnimatedRotatableSprite2D


##Set this value to true if the blank building sprite looks same in all the rotations
var grid_object: GridObject
@export var is_symetric: bool = true

signal preview_change(view_func: Callable)

@export_group("Position based on rotations")

@export_subgroup("right", "right")
@export var right_position: Vector2i:
	set(new_pos):
		right_position = new_pos
		right_preview.call()
@export_tool_button("Preview", "GuiVisibilityVisible")
var right_preview = func():
	if grid_object is GridObject:
		grid_object.view_right.call()
	offset = right_position
@export_tool_button("Save", "Save")
var right_save = func():
	right_position = offset

@export_subgroup("down", "down")
@export var down_position: Vector2i:
	set(new_pos):
		down_position = new_pos
		down_preview.call()
@export_tool_button("Preview", "GuiVisibilityVisible")
var down_preview = func():
	if grid_object is GridObject:
		grid_object.view_down.call()
	offset = down_position
@export_tool_button("Save", "Save")
var down_save = func():
	down_position = offset

@export_subgroup("left", "left")
@export var left_position: Vector2i:
	set(new_pos):
		left_position = new_pos
		left_preview.call()
@export_tool_button("Preview", "GuiVisibilityVisible")
var left_preview = func():
	if grid_object is GridObject:
		grid_object.view_left.call()
	offset = left_position
@export_tool_button("Save", "Save")
var left_save = func():
	left_position = offset

@export_subgroup("up", "up")
@export var up_position: Vector2i:
	set(new_pos):
		up_position = new_pos
		up_preview.call()
@export_tool_button("Preview", "GuiVisibilityVisible")
var up_preview = func():
	if grid_object is GridObject:
		grid_object.view_up.call()
	offset = up_position
@export_tool_button("Save", "Save")
var up_save = func():
	up_position = offset



func GO_init() -> void:
	grid_object = get_parent()
	if is_symetric:
		update_symetric()
	update_offset()


func update_symetric() -> void:
	rotation = -grid_object.rotation

func update_offset() -> void:
	match (((360 + int(grid_object.rotation_degrees)) % 360) / 90) % 4:
		0:
			offset = right_position
		1:
			offset = down_position
		2:
			offset = left_position
		3:
			offset = up_position
	for c in get_children():
				if c is Sprite2D:
					(c as Sprite2D).offset = offset
	
	
