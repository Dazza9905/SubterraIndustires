extends PlacementRule
class_name BetterCollisionCheck


@export_flags_2d_physics var these_layers = 256
#@export_flags_2d_physics var cannot_collide_with_layers = 0

func validate_condition() -> RuleResult:
	var grid_object = _params.target
	var did_pass: bool = true
	for child in grid_object.get_children():
		if child.is_class("Area2D"):
			print(child.name, " has: ", (child as Area2D).collision_layer)
			
			#contains layer
			if (child as Area2D).collision_layer & these_layers != 0:
				print("\t contains spefied mask")
				
				#set collision mask
				#(child as Area2D).collision_mask = cannot_collide_with_layers
				#print("\tscans for: ", (child as Area2D).collision_mask)
				
				
				for c_area in (child as Area2D).get_overlapping_areas():
					print(c_area.get_parent(), " AND ", child.get_parent())
					if c_area.get_parent() != grid_object:
						print("\tcollided with ", c_area.name)
						did_pass = false
					else:
						print("\tsame object")
				for c_stb in (child as Area2D).get_overlapping_bodies():
					print(c_stb, " AND ", grid_object)
					if c_stb != grid_object:
						print("\tcollided with ", c_stb.name)
						did_pass = false
					else:
						print("\tsame object")
	return RuleResult.new(self,did_pass,"")
