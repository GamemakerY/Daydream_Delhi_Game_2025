extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	
	# Assume camera_pos and view are defined for the camera bounds
	var camera_pos = get_viewport().get_camera_2d().global_position
	var view_size = get_viewport_rect().size / 2 # Half size for clamping
		# Calculate character's new position

		# Clamp the character's position to the camera bounds
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("ui_w") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_pressed("ui_a"):
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("Run")
		
	if Input.is_action_pressed("ui_d"):
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("Run")
	
	if Input.is_action_just_pressed("ui_q"):
		$AnimatedSprite2D.play("Attack")
	
	if not $AnimatedSprite2D.animation == 'Attack':
		if !Input.is_anything_pressed():
			$AnimatedSprite2D.play("Idle")
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_a", "ui_d")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var min_x = camera_pos.x - view_size.x
	var max_x = camera_pos.x + view_size.x
	var min_y = camera_pos.y - view_size.y
	var max_y = camera_pos.y + view_size.y
	
	global_position.x = clamp(global_position.x, min_x, max_x)
	global_position.y = clamp(global_position.y, min_y, max_y)

	move_and_slide()
