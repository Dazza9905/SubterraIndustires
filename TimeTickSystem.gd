extends Node

var ticks_per_second: int = 32
var tick_max_time: float = 1.0 / ticks_per_second
var tick_delta: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(tick_delta)
#	TODO: tick() signal function
#	TODO: spammy print()
	pass
