@tool
class_name IOComponent
extends Component

#JUST FOR STTING IN EDOTOR
#for setting and reading
@export var cell_offset: Vector2i :
	set(new_offset):
		cell_offset = new_offset
		#if Engine.is_editor_hint():
		self.position = ((cell_offset * Globals.TILE_SIZE) as Vector2)
		
#just for seeting in editor, read the angle if needed
@export var base_side: Side:
	set(new_base_side):
		base_side = new_base_side
		match base_side:
			SIDE_RIGHT:
				self.rotation_degrees = 0
			SIDE_BOTTOM:
				self.rotation_degrees = 90
			SIDE_LEFT:
				self.rotation_degrees = 180
			SIDE_TOP:
				self.rotation_degrees = 270
	get():
		assert("Read the specific side")
		return base_side

#Holds reference to connedted object
var IO_connection: IOComponent


func get_io_con():
	var target_XY = GlobalMethods.rotate(self.cell_offset + self.get_parent_GO().main_cell + GlobalMethods.rotate(Vector2(1,0), roundi(self.rotation_degrees)), roundi(self.get_parent_GO().rotation_degrees))
	print("TARGET:", target_XY)


func refresh_IO_connection():
	print("===", self.name, "===")
	get_io_con()
	var grid_ref_system: GridReferenceSystem = self.get_parent().get_parent().get_parent()
	
	var target_GO = grid_ref_system.get_GO_from_XY( GlobalMethods.rotate(self.cell_offset + self.get_parent_GO().main_cell + GlobalMethods.rotate(Vector2(1,0), roundi(self.rotation_degrees)), roundi(self.get_parent_GO().rotation_degrees)))
	print(get_target_cell())
	if target_GO == parent_GO: #err if its own
		printerr("IOComponent is targeting its own GridObject")
		return
	if (target_GO != null):
		IO_connection = target_GO.request_connection(self)
	else:
		print("no target GO")
	
func connect_to_tick():
	refresh_IO_connection()
	

func get_target_cell() -> Vector2i:
	print("before: ", rotation_degrees)
	return GlobalMethods.rotate((GlobalMethods.rotate(Vector2i(1, 0), roundi(rotation_degrees)) + cell_offset + parent_GO.main_cell), roundi(parent_GO.rotation_degrees))
	
	
#=========DEBUG============
var debug_in: PackedScene = preload("res://debug/io_ports/in_debug.tscn")
var debug_out: PackedScene = preload("res://debug/io_ports/out_debug.tscn")
var in_sprite: Sprite2D
var out_sprite: Sprite2D

func _process(delta: float) -> void:
	if (IO_connection is IOComponent): #is valid conn
		if (Globals.show_debug_io_conn):
			(out_sprite.get_child(0) as Sprite2D).visible = true
			(in_sprite.get_child(0) as Sprite2D).visible = true
		else:
			(out_sprite.get_child(0) as Sprite2D).visible = false
			(in_sprite.get_child(0) as Sprite2D).visible = false
	else: 
		(out_sprite.get_child(0) as Sprite2D).visible = false
		(in_sprite.get_child(0) as Sprite2D).visible = false

func _init() -> void:
	if (OS.has_feature("debug")):
		in_sprite = debug_in.instantiate()
		out_sprite = debug_out.instantiate()
		#in_sprite.rotation_degrees = io_deg
		#out_sprite.rotation_degrees = io_deg
