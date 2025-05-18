extends CharacterBody2D
class_name Player
# Variable for movement speed
var speed = 5000

@export var conveyor_speed = 16

@export var detector_area: Area2D
@export var inventory: PlayerInventory

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if Input.is_action_pressed("camera_zoom_out"):
			if ($Camera2D.zoom.x > 2.5):
				$Camera2D.zoom *= Vector2(0.952, 0.952)
		if Input.is_action_pressed("camera_zoom_in"):
			if ($Camera2D.zoom.x < 8):
				$Camera2D.zoom *= Vector2(1.05, 1.05)
				
		if Input.is_action_pressed("toggle_inventory"):
			inventory.toggle_inventory()
				
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			if ($Camera2D.zoom.x < 8):
				$Camera2D.zoom *= Vector2(1.07, 1.07)
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			if ($Camera2D.zoom.x > 2.5):
				$Camera2D.zoom *= Vector2(0.95, 0.95)

func _physics_process(delta):
	var colliders = detector_area.get_overlapping_bodies()
	
	var conveyor_velocity = Vector2.ZERO
	
	
	
	
	for collider in colliders:
		if collider != null and collider.name.begins_with("belt"):
			#print("Collided with: " + collider.name)
			conveyor_velocity = Vector2.RIGHT.rotated(collider.rotation) * conveyor_speed
		if collider.name == "find_remains":
			Globals.get_ObjectiveSystem().complete_task("find_remains")
	
	

	
	var input_direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	# Normalize input direction to maintain consistent speed when moving diagonally
	if input_direction.length() > 0:
		input_direction = input_direction.normalized()
	
	var running_mult = 1
	if Input.is_action_pressed("sprint"):
		running_mult = 1.5
	
	var input_velocity = (input_direction * speed * running_mult)*delta
	
	
	# Apply delta to scale movement by frame time for frame rate independence
	velocity = (input_velocity + conveyor_velocity)
	
	var global_deg_move: float
	for overlaped in detector_area.get_overlapping_areas():
		global_deg_move = (overlaped.get_parent() as Node2D).rotation

		var first_child := overlaped.get_child(0)
		if first_child is PlayerMoveInfo:
			global_deg_move += (first_child as PlayerMoveInfo).dir_degrees
		#print(global_deg_move)
		velocity += Vector2.from_angle(global_deg_move) * 32
		break
			
	# Move the character using the move_and_slide method
	move_and_slide()

func serialize() -> Dictionary: 
	var save_dict: Dictionary = {
		position = var_to_str(position),
		inventory = []
	}
	
	for slot_comp in inventory.components:
		save_dict.inventory.push_back(slot_comp.serialize())
		
	return save_dict
	

func deserialize(load_dict: Dictionary) -> void:
	position = str_to_var(load_dict.position)
	
	inventory.update_slots()
	
	var i = 0
	for slot_comp in inventory.components:
		slot_comp.deserialize(load_dict.inventory[i])
		i += 1
