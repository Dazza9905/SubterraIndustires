extends Node
class_name TimeTickSystem

var ticks_per_second: int = 4
var tick_max_delta: float = 1.0 / ticks_per_second
var tick_delta: float = 0
var tick_num: int = 0
signal machine_tick
signal belt_tick

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(tick_delta)
	tick_delta = tick_delta + delta
	if(tick_delta >= tick_max_delta):
		tick_delta = tick_delta - tick_max_delta
		tick_num = tick_num + 1
		#print("Tick num: ", tick_num, "\t Tick delta: ", tick_delta)
		if tick_num % 2 == 0:
			emit_signal("belt_tick")
			#print("Belt tick!")
		else:
			emit_signal("machine_tick")
			#print("Machine tick!")
			
	pass
