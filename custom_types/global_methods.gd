extends Node

func rotate(vector: Vector2i,  degrees: int) -> Vector2i:
	if (roundi(degrees) % 90 == 0):
		var rotated_vector = Vector2(vector).rotated(deg_to_rad(degrees))
		return Vector2i(rotated_vector.round())
	else:
		printerr("rotation is not multiple of 90")
		return vector
		

	

	

func are_IO_COMPs_diff(comp1: Node, comp2: Node) -> bool:
	return (comp1 is InputComponent and comp2 is OutputComponent) or (comp1 is OutputComponent and comp2 is InputComponent)
