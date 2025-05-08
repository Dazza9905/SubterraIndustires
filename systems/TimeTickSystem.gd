@icon("res://art/downloaded/icon_godot_node/node/icon_time.png")
extends Node
class_name TimeTickSystem

@export var ticks_per_second: int = 4:
	set(new_tps):
		ticks_per_second = new_tps
		tick_max_delta = 1.0 / ticks_per_second
		
var tick_max_delta: float = 1.0 / ticks_per_second
var tick_delta: float = 0
var tick_num: int = 0
@export var paused = true
signal machine_tick
signal belt_tick
signal tick

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

var global_frame: int = 0
var _time_accum: float = 0.0

const ANIMATION_FPS := 32

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not paused:
		#ANIMATION
		_time_accum += delta
		if _time_accum >= 1.0 / ANIMATION_FPS:
			_time_accum -= 1.0 / ANIMATION_FPS
			global_frame += 1
			
		#ITCKS	
		tick_delta = tick_delta + delta
		if(tick_delta >= tick_max_delta):
			tick_delta = tick_delta - tick_max_delta
			tick_num = tick_num + 1
			emit_signal("tick")
			if tick_num % 2 == 0:
				#print("BELT TICK:")
				emit_signal("belt_tick")
				
			else:
				#print("MACHINE TICK:")
				emit_signal("machine_tick")
		
		
	
