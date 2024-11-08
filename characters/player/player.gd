extends CharacterBody2D

# Variable for movement speed
var speed = 200



func _physics_process(delta):
	var conveyor_velocity = Vector2.ZERO
	var conveyor_speed = 32
	var colliders = $Area2D.get_overlapping_bodies()
	
	for collider in colliders:
		if collider != null and collider.name.begins_with("Belt"):
			print("Collided with: " + collider.name)
			conveyor_velocity = Vector2.RIGHT.rotated(collider.rotation) * conveyor_speed
			break
	
	var input_direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	# Normalize input direction to maintain consistent speed when moving diagonally
	if input_direction.length() > 0:
		input_direction = input_direction.normalized()	
		
	var input_velocity = input_direction * speed

	# Apply delta to scale movement by frame time for frame rate independence
	velocity = input_velocity + conveyor_velocity
	

	# Move the character using the move_and_slide method
	move_and_slide()
