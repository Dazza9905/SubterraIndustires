extends Component
class_name MinerComp

@export var slot: SlotComponent
@export var area: Area2D
@export var tick_to_mine: int = 0
var current_tick: int = 0
var item: Item
@export var limit: bool = false
@export var allow_to_mine: Array[Item]

func _process_tilemap_collision(body_rid: RID, current_tilemap: TileMapLayer):
	var collision_coords: Vector2 = current_tilemap.get_coords_for_body_rid(body_rid)
	var tile_data: TileData =  current_tilemap.get_cell_tile_data(collision_coords)
	var source_item: Item = tile_data.get_custom_data_by_layer_id(0)
	if limit:
		for check_item in allow_to_mine:
			if source_item == check_item:
				item = source_item
	else:
		item = source_item
	print(source_item.name)
	area.body_shape_entered.disconnect(_process_tilemap_collision)
	area.queue_free()

func connect_to_tick() -> void:
	Globals.get_tts().machine_tick.connect(_on_machanine_tick)
	area.body_shape_entered.connect(_on_body_shape_entered)
	#if bodies.size() == 0:
		#print("did not detet collision")
	#for body in bodies:
		#print("collided: ", bodies)
		#if body.has_node("SupplyNode"):
			#item = (body.get_node("SupplyNode") as SupplyNode).source_item
			#area.queue_free()

func _on_body_shape_entered(body_rid: RID, body: Node2D, _body_shape_index: int, _local_shappe_index: int):
	if body is TileMapLayer:
		_process_tilemap_collision(body_rid, body)

func _on_machanine_tick() -> void:
	current_tick += 1
	if current_tick >= tick_to_mine:
		current_tick = 0
		slot.give_item(item)
