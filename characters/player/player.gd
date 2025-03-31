extends CharacterBody2D

# Variable for movement speed
var speed = 5000

var conveyor_speed = 32

@export var detector_area: Area2D
@export var inventory: PlayerInventory

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if Input.is_action_pressed("camera_zoom_out"):
			if ($Camera2D.zoom.x > 3):
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
			if ($Camera2D.zoom.x > 3):
				$Camera2D.zoom *= Vector2(0.95, 0.95)

func _physics_process(delta):
	var colliders = detector_area.get_overlapping_bodies()
	
	var conveyor_velocity = Vector2.ZERO
	
	for collider in colliders:
		if collider != null and collider.name.begins_with("belt"):
			print("Collided with: " + collider.name)
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
		
	var input_velocity = (input_direction * speed)*delta

	# Apply delta to scale movement by frame time for frame rate independence
	velocity = (input_velocity + conveyor_velocity)
	

	# Move the character using the move_and_slide method
	move_and_slide()
