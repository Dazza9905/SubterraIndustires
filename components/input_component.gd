extends IOComponent
class_name InputComponent

func get_IO_port_connection():
	
	Globals.ref_system.get_GO(self.global_pos() + v)



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
