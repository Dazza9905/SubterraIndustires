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
		
var global_pos: Vector2i:
	get:
		return parent_GO.main_cell + cell_offset
		
var global_rot_rad: float:
	get:
		return get_parent_GO().rotation + self.rotation
		
var side_vector: Vector2i:
	get:
		return Vector2.from_angle(global_rot_rad)
		
		
#Holds reference to connedted object
var IO_connection: IOComponent

func get_io_con():
	var target_XY: Vector2i
	target_XY = global_pos
	print("TARGET:", target_XY)
	var target_GO: GridObject = get_GRS().get_GO_from_XY(target_XY)
	if (target_GO):
		IO_connection = target_GO.request_connection(self)

func _notification(what: int) -> void:
	if (what == NOTIFICATION_EXIT_TREE):
		if (IO_connection == null):
			print(self.name , " io-conn is null even in notif")
		else:
			IO_connection.IO_connection = null
			print(IO_connection.IO_connection)


func _exit_tree() -> void:
	if (IO_connection == null):
		pass
		print(self.name , " io-conn is null even in notif")
	#IO_connection.IO_connection == null

func connect_to_tick():
	get_io_con()

#=========DEBUG============
var debug_in: PackedScene = preload("res://debug/io_ports/in_debug.tscn")
var debug_out: PackedScene = preload("res://debug/io_ports/out_debug.tscn")
var in_sprite: Sprite2D
var out_sprite: Sprite2D

func _process(delta: float) -> void:
	if (IO_connection != null): #is valid conn
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

static func facing_opposite_dir(comp1: IOComponent, comp2: IOComponent) -> bool:
	var comp1_deg: float = comp1.rotation_degrees + comp1.parent_GO.rotation_degrees
	var comp2_deg: float = comp2.rotation_degrees + comp2.parent_GO.rotation_degrees
	print("Degs: ", comp1_deg, " -- ", comp2_deg)
	return is_equal_approx(roundi(comp1_deg + 180.0) % 360, comp2_deg)


static func are_diff(comp1: Node, comp2: Node) -> bool:
	return (comp1 is InputComponent and comp2 is OutputComponent) or (comp1 is OutputComponent and comp2 is InputComponent)
