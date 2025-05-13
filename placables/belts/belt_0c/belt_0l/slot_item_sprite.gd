extends Sprite2D
class_name SlotItemSprite

@export var slot_component: SlotComponent

func _ready() -> void:
	slot_component.slot_contents_changed.connect(update)
	update()

func GO_init() -> void:
	rotation = -get_parent().rotation
	


func update():
	if slot_component.item:
		texture = slot_component.item.texture
		visible = true
	else: 
		texture = null
		visible = false
