extends Component
class_name ObjectiveComponent

@export var craft_comp: CrafterComponent
var objective_system: ObjectiveSystem

func connect_to_tick():
	objective_system = Globals.get_ObjectiveSystem()
	craft_comp.produced_items.connect(_on_crafter_comp_produced)

func _on_crafter_comp_produced(item: Item, amount: int):
	objective_system.complete_produce(item, amount)
