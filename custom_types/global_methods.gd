extends Node

func rotate(vector: Vector2i,  degrees: int) -> Vector2i:
	if (roundi(degrees) % 90 == 0):
		var rotated_vector = Vector2(vector).rotated(deg_to_rad(degrees))
		return Vector2i(rotated_vector.round())
	else:
		printerr("rotation is not multiple of 90")
		return vector
		

	
func are_IO_COMPs_facing_opposite_dir(this_comp: IOComponent, calling_comp: IOComponent) -> bool:
	var this_comp_g_deg: float = this_comp.rotation_degrees + this_comp.parent_GO.rotation_degrees
	var calling_comp_g_deg: float = calling_comp.rotation_degrees + calling_comp.parent_GO.rotation_degrees
	print(this_comp_g_deg, "--", calling_comp_g_deg)
	return is_equal_approx((this_comp_g_deg + 180.0) % 360.0, calling_comp_g_deg)
	

func are_IO_COMPs_diff(comp1: Node, comp2: Node) -> bool:
	return (comp1 is InputComponent and comp2 is OutputComponent) or (comp1 is OutputComponent and comp2 is InputComponent)
