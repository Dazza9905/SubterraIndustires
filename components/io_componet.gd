@tool
class_name IOComponent
extends Component

@export var cell_offset: Vector2i :
	set(new_cell_offset):
		in_sprite.position = new_cell_offset * 32
		out_sprite.position = new_cell_offset * 32
		cell_offset = new_cell_offset
@export var io_direction: Side :
	set(new_io_direction):
		var new_rotation = 20
		match new_io_direction:
			SIDE_RIGHT:
				new_rotation = 0
			SIDE_TOP:
				new_rotation = -90
			SIDE_BOTTOM: 
				new_rotation = 90
			SIDE_LEFT:
				new_rotation = 180
			_:
				print("not matched")
			
		print(new_rotation)
		in_sprite.rotation = new_rotation
		out_sprite.rotation = new_rotation
		io_direction = new_io_direction

var debug_in: PackedScene = preload("res://debug/io_ports/in_debug.tscn")
var debug_out: PackedScene = preload("res://debug/io_ports/out_debug.tscn")
var in_sprite: Sprite2D = debug_in.instantiate()
var out_sprite: Sprite2D = debug_out.instantiate()

func global_pos() -> Vector2i:
	return parent_GO.occupied_cells
	
func get_IO_port_connection():
	var a = Globals.grid_ref_system

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
