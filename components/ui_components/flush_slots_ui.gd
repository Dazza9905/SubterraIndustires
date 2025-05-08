extends Button

@export var ui_link_ids: Array[String]

var slot_compoents: Array[SlotComponent]

func link_to_component(components: Array[Component]) -> void:
	for comp in components:
		if comp is SlotComponent and ui_link_ids.has(comp.ui_link_id):
			#print(self.name, " linked to ", comp.name)
			slot_compoents.append(comp)

func _pressed() -> void:
	for comp in slot_compoents:
		comp._amount = 0
