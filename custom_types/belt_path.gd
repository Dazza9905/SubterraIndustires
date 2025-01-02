extends RefCounted
class_name BeltPath

var path: Array[BeltComponent]

func _init(belt: BeltComponent) -> void:
	path.append(belt)
	
func append_belt(belt: BeltComponent):
	path.append(belt)

func prepend_belt(belt: BeltComponent):
	path.insert(0, belt)

static func join_belt_paths(bp1: BeltPath, bp2: BeltPath):
	bp1.path.append_array(bp2.path)
	for belt_comp in bp2.path:
		belt_comp.belt_path = bp1

func update():
	pass
