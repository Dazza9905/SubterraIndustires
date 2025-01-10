extends RefCounted
class_name BeltPath

var id: int
var path: Array[BeltComponent]

func _init(belt: BeltComponent) -> void:
	path.append(belt)
	id = randi_range(1000, 9999)
	
func append_belt(belt: BeltComponent):
	path.push_back(belt)

func prepend_belt(belt: BeltComponent):
	path.push_front(belt)

static func join_belt_paths(bp1: BeltPath, bp2: BeltPath):
	bp1.path.append_array(bp2.path)
	for belt_comp in bp2.path:
		belt_comp.belt_path = bp1

func belt_removed(belt_comp):
	var belt_comp_index = path.rfind(belt_comp)
	print("\tFOR BeltPath:")
	if(path.size() == 1):
		path.erase(belt_comp)
		print("was freed")
	elif(belt_comp_index == path.size()-1):
		remove_last(belt_comp)
		print("last belt was removed")
	elif(belt_comp_index == 0):
		remove_first(belt_comp)
		print("first belt was removed")
	else:
		split_at(belt_comp_index)
		
	print(path)
		

func remove_last(belt_comp: BeltComponent):
	if(path.back() == belt_comp):
		path.remove_at(path.size() - 1)
		
func remove_first(belt_comp: BeltComponent):
	if(path[0] == belt_comp):
		path.remove_at(0)

func split_at(index_of_removed: int):
	#FIXME insted of calculating it, store the index in BeltComponent. Can be also user elsewere in debug
	print("Original:")
	for i in range(0, path.size()):
		print(i)
	var temp_bp = BeltPath.new(path[index_of_removed+1])
	path[index_of_removed+1].belt_path = temp_bp
	print("New (1st):")
	for i in range(0, temp_bp.path.size()):
		print(i)
		
	for i in range(index_of_removed+2, path.size()):
		path[i].belt_path = temp_bp
		temp_bp.append_belt(path[i])
		
	print("New (all):")
	for i in range(0, temp_bp.path.size()):
		print(i)
	
	path.resize(index_of_removed)
		
	print("Original (updated):")
	for i in range(0, path.size()):
		print(i)

func update():
	pass
