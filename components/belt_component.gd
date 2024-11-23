extends Component
class_name BeltComponent


@export var input: InputComponent
@export var output: OutputComponent
@export var belt_path: BeltPath
@export var debug_label: Label

func connect_to_BP():
	pass

func update() -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect_to_tick()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func connect_to_tick():
	pass
	
