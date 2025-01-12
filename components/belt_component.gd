extends Component
class_name BeltComponent


@export var input: InputComponent
@export var output: OutputComponent
var belt_path: BeltPath

var in_bp: BeltPath:
	get:
		return (input.IO_connection.parent_GO.get_node("Components/BeltComponent") as BeltComponent).belt_path
var out_bp: BeltPath:
	get:
		return (output.IO_connection.parent_GO.get_node("Components/BeltComponent") as BeltComponent).belt_path

func is_there_belt(io_comp: IOComponent) -> bool:
	if(io_comp.IO_connection is IOComponent):
		return io_comp.IO_connection.get_parent_GO().has_node("Components/BeltComponent")
	return false

func update_belt(output_too: bool) -> void:
	if(output_too):
		if (!output.slot.is_empty()):
			if (output.IO_connection is IOComponent):
				var error: Error = output.IO_connection.slot.give_item(output.slot.item)
				if error == OK:
					output.slot.take()
	if input.slot.is_empty():
		if (input.IO_connection is IOComponent):
			var returned_item: Enums.MATERIAL_ITEM = input.IO_connection.slot.take_any_type()
			input.slot.give_item(returned_item)




func connect_to_tick():
	connect_to_BP()

#TODO: KOKOT DOPROGRAMUJ DEI$"."NICIALIZACIUS BeltCOmponentu
#split baths functions, tu v tomto script, nieco s notif eventom
#bum tu je error lebo si to itak nevsimnes
func _notification(what: int) -> void:
	if (what == NOTIFICATION_EXIT_TREE):
		print("IN JUST REMOVED BeltComponent:")
		belt_path.belt_removed(self)

func connect_to_BP():
	print("\tFOR BeltPath:")
	
	if(not is_there_belt(input) and not is_there_belt(output)):
		belt_path = BeltPath.new(self)
		print("\t\tCreated BeltPath")
	elif(is_there_belt(input) and is_there_belt(output)):
		if(in_bp == out_bp):
			in_bp.append_belt(self)
			belt_path = in_bp
			print("\t\tOuuu a circle! Appened it self to the END of th BeltPath")
		else:
			in_bp.append_belt(self)
			belt_path = in_bp
			BeltPath.join_belt_paths(in_bp, out_bp)
			print("\t\tAppended it self and joined the two BeltPaths")
	elif(is_there_belt(input) and not is_there_belt(output)):
		if(is_there_belt(input)):
			in_bp.append_belt(self)
			belt_path = in_bp
			print("\t\tAppended it self to another BeltPath")
	else: 
		out_bp.prepend_belt(self)
		belt_path = out_bp
		print("\t\tPreppended it self to another BeltPath")
