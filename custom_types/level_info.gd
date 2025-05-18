extends Node
class_name LevelInfo

var current_floor = 0:
	set(n_val):
		if n_val > 2:
			n_val = 2
		elif n_val > 0:
			n_val = 0
			
		if current_floor != n_val:
			current_floor = n_val
			GameManager.save_world()
			GameManager.load_world(Globals.lvl_uuid, current_floor)

func serialize() -> Dictionary:
	var save_dict: Dictionary = {
		current_floor = var_to_str(current_floor)
	}
	return save_dict
	
func deserialize(load_dict: Dictionary) -> void:
	current_floor = str_to_var(load_dict.current_floor)
	
