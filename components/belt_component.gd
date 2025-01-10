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


func update_belt(output_too: bool) -> void:
	if(output_too):
		if (!input.slot.is_empty()):
			if (output.IO_connection is IOComponent):
				var did_pass: bool = output.IO_connection.slot.pass_item(output.slot.item)
				if (did_pass):
					output.slot.give_item()
				print("passed")
	if input.slot.is_empty():
		if (input.IO_connection is IOComponent):
			var returned_item: Enums.MATERIAL_ITEM = input.IO_connection.slot.request_any_type()
			if (returned_item != Enums.MATERIAL_ITEM.NONE):
				input.slot.item = returned_item
				input.slot.amount += 1
			print("requested")




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
	
	if(input.IO_connection == null and output.IO_connection == null):
		belt_path = BeltPath.new(self)
		print("\t\tCreated BeltPath")
	elif(input.IO_connection is IOComponent and output.IO_connection is IOComponent):
		if(in_bp == out_bp): 
			in_bp.append_belt(self)
			belt_path = in_bp
			print("\t\tOuuu a circle! Appened it self to the END of th BeltPath")
		else:
			in_bp.append_belt(self)
			belt_path = in_bp
			BeltPath.join_belt_paths(in_bp, out_bp)
			print("\t\tAppended it self and joined the two BeltPaths")
	elif(input.IO_connection is IOComponent and output.IO_connection == null):
		in_bp.append_belt(self)
		belt_path = in_bp
		print("\t\tAppended it self to another BeltPath")
	else: 
		out_bp.prepend_belt(self)
		belt_path = out_bp
		print("\t\tPreppended it self to another BeltPath")
