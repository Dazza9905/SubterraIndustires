extends Component
class_name BeltComponent


@export var input: InputComponent
@export var output: OutputComponent
@export var debug_label: Label
var belt_path: BeltPath

var in_bp: BeltPath:
	get:
		return (input.IO_connection.parent_GO.get_node("Components/BeltComponent") as BeltComponent).belt_path
var out_bp: BeltPath:
	get:
		return (output.IO_connection.parent_GO.get_node("Components/BeltComponent") as BeltComponent).belt_path


func update() -> void:
	pass

func connect_to_tick():
	if(input.IO_connection == null and output.IO_connection == null):
		belt_path = BeltPath.new(self)
	elif(input.IO_connection != null and output.IO_connection != null):
		if(in_bp == out_bp):
			in_bp.append_belt(self)
		else:
			in_bp.append_belt(self)
			BeltPath.join_belt_paths(in_bp, out_bp)
			
#TODO: KOKOT DOPROGRAMUJ DEINICIALIZACIUS BeltCOmponentu
#split baths functions, tu v tomto script, nieco s notif eventom
bum tu je error lebo si to itak nevsimnes


func connect_to_BP():
	pass
