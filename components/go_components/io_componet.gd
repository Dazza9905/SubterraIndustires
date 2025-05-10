@tool
class_name IOComponent
extends Component

@export var cell_offset: Vector2i :
	set(new_offset):
		cell_offset = new_offset
		#if Engine.is_editor_hint():
		self.position = ((cell_offset * Globals.TILE_SIZE) as Vector2)
		#just for seeting in editor, read the angle if needed
		update_IO_port_view()
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
		update_IO_port_view()
	get():
		#assert(false, "Read the specific side")
		return base_side
@export var slot: SlotComponent
	
var self_XY: Vector2i:
	get:
		return parent_GO.main_cell + GF.rotate(cell_offset, parent_GO.rotation)
var target_XY: Vector2i:
	get:
		return parent_GO.main_cell + GF.rotate(cell_offset, parent_GO.rotation) + GF.rotate(GF.rotate(Vector2i.RIGHT, rotation), parent_GO.rotation)
var IO_connection: IOComponent

@export var display_port: bool = true:
	set(new_val):
		if new_val == true:
			pass
			update_IO_port_view()
		else:
			for child in self.get_children():
				child.queue_free()
		display_port = new_val


func update_IO_port_view() -> void:
	if display_port == false:
		return
	var texture: Texture2D = preload("uid://ckqb7yvo30sbi") #world_io_comp_atlas.png
	
	var shadow: Sprite2D = Sprite2D.new()
	var highlight: Sprite2D = Sprite2D.new()
	
	highlight.z_index = 2
	
	shadow.texture = AtlasTexture.new()
	highlight.texture = AtlasTexture.new()
	
	for child in self.get_children():
		child.queue_free()
	
	self.add_child(shadow)
	self.add_child(highlight)

	
	(shadow.texture as AtlasTexture).atlas = texture
	(highlight.texture as AtlasTexture).atlas = texture

	var column: int
	if parent_GO != null:
		column = (base_side + (((360 + int(parent_GO.rotation_degrees)) % 360) / 90)) % 4
		#print(self.name, ": ", column)
		#print("\t", parent_GO.rotation_degrees)
		#print("\t", (360 + int(parent_GO.rotation_degrees)))
	else:
		column = base_side
	var row : int = 1
	if self is OutputComponent:
		row = 0
	
	(shadow.texture as AtlasTexture).region = Rect2(column * 16, 2 * 16, 16, 16)
	(highlight.texture as AtlasTexture).region = Rect2(column * 16, row * 16, 16, 16)
	

	shadow.position = Vector2i.RIGHT * 16
	highlight.position = Vector2i.RIGHT  * 16

func print_io_con() -> void:

	var target_GO: GridObject = Globals.get_GRS().get_GO_from_XY(target_XY)
	if (target_GO):
		IO_connection = target_GO.request_connection(self)
	#else:
		#print("\tno GO on target_XY")
		
func accepts_conn_from(comp_to_test: IOComponent) -> bool:
	if(IOComponent.are_diff(self, comp_to_test)): #are diff
		#if(IOComponent.are_facing_eachother(self, comp_to_test)): #are facing eachother (THIS REDUNDAND BECAUSE OF NEXT STEP, BUT JUST TO BE SURE)
		if(self_XY == comp_to_test.target_XY and comp_to_test.self_XY == target_XY): #are actually tageting each other
			return true
		#else:
			#print("\t\tno same position:")
	return false

func _notification(what: int) -> void:
	if (what == NOTIFICATION_EXIT_TREE):
		if (IO_connection == null):
			pass
			#print(self.name , " io-conn is null even in notif")
		else:
			IO_connection.IO_connection = null
			#print(IO_connection.IO_connection)

func _exit_tree() -> void:
	if (IO_connection == null):
		pass
		#print(self.name , " io-conn is null even in notif")
	#IO_connection.IO_connection == null
	if not Engine.is_editor_hint():
		queue_free()

func connect_to_tick() -> void:
	update_IO_port_view()
	print_io_con()
#		
func get_io_info() -> String:
	return name + " @" + str(self_XY) + " >" + str(target_XY)

static func are_facing_eachother(comp1: IOComponent, comp2: IOComponent) -> bool:
	var comp1_deg: float = comp1.rotation_degrees + comp1.parent_GO.rotation_degrees
	var comp2_deg: float = comp2.rotation_degrees + comp2.parent_GO.rotation_degrees
	var result := is_equal_approx(roundi(comp1_deg + 180.0) % 360, comp2_deg)
	#if !result:
		#print("\t\tare not facing eachother")
		#print("\t\t\tDegs: ", comp1_deg, " -- ", comp2_deg)
	return result

static func are_diff(comp1: Node, comp2: Node) -> bool:
	var result := (comp1 is InputComponent and comp2 is OutputComponent) or (comp1 is OutputComponent and comp2 is InputComponent)
	#if !result:
		#print("\t\tare not diff:")
	return result
