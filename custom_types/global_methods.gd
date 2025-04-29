extends Node

func rotate(vector: Vector2i,  rad: float) -> Vector2i:
	if (roundi(rad_to_deg(rad)) % 90 == 0): 
		var rotated_vector: Vector2 = Vector2(vector).rotated(rad)
		return Vector2i(rotated_vector.round())
	else:
		printerr("rotation is not multiple of 90")
		return vector

func are_IO_COMPs_diff(comp1: Node, comp2: Node) -> bool:
	return (comp1 is InputComponent and comp2 is OutputComponent) or (comp1 is OutputComponent and comp2 is InputComponent)
	 
func snap_90(angle: float) -> float:
	return round(angle / 90.0) * 90.0
