extends Component
class_name CoreDrillComp

@export var collect_component: CollectComponent
@export var anim_player: AnimationPlayer

@export var full_progress: int = 30
@export var current_progress: int = 0

var finised_drilling: bool = false

var enough_drill_heads: bool = false

var is_drilling: bool = false

signal drilled

func connect_to_tick() -> void:
	collect_component.did_fullfill.connect(set_drill_heads)
	Globals.get_tts().machine_tick.connect(tick)

func set_drill_heads():
	enough_drill_heads = true

func tick() -> void:
	if current_progress < full_progress and enough_drill_heads:
		start_mine() 


func start_mine() -> void:
	enough_drill_heads = false
	is_drilling = true
	anim_player.play("drilling")
	anim_player.animation_finished.connect(finish_mine, CONNECT_ONE_SHOT)

func finish_mine(anim_name: String) -> void:
	current_progress += 1
	if current_progress >= full_progress:
		finised_drilling = true
	is_drilling = false
	drilled.emit()
	collect_component.reset()
	
func serialize() -> Dictionary:
	var save_dict: Dictionary = {
		is_drilling = var_to_str(is_drilling),
		current_progress = var_to_str(current_progress)
	}
	return save_dict
	
func deserialize(comp_data: Dictionary) -> void:
	current_progress = str_to_var(comp_data.current_progress) + int(str_to_var(comp_data.is_drilling))
