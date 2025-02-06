extends Component
class_name MinerComp

@export var slot: SlotComponent
@export var area: Area2D
var item: Item

func connect_to_tick() -> void:
	Globals.get_tts().machine_tick.connect(_on_machanine_tick)
	#var bodies = area.get_overlapping_bodies()
	#if bodies.size() == 0:
		#print("did not detet collision")
	#for body in bodies:
		#print("collided: ", bodies)
		#if body.has_node("SupplyNode"):
			#item = (body.get_node("SupplyNode") as SupplyNode).source_item
			#area.queue_free()
		
	
func _on_machanine_tick() -> void:
	if area:
		var bodies = area.get_overlapping_bodies()
		if bodies.size() == 0:
			print("did not detet collision")
			Globals.get_tts().machine_tick.disconnect(_on_machanine_tick)
			area.queue_free()
			area = null
	
		for body in bodies:
			print("collided: ", bodies)
			if body.source_item != null:
				item = body.source_item
				area.queue_free()
				area = null
	
	slot.give_item(item)
