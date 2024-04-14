extends CharacterBody2D
class_name Player

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D
@export var SPEED = 300.0
@export var JUMP= -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	GameManager.player = self
	

func _physics_process(delta):
	
	if Input.is_action_just_pressed("left") or Input.is_action_pressed("ui_left"):
		sprite.scale.x = abs(sprite.scale.x) * -1
		
	if Input.is_action_just_pressed("right") or Input.is_action_pressed("ui_right"):
		sprite.scale.x = abs(sprite.scale.x)
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = 0

	if Input.is_action_pressed("left") or Input.is_action_pressed("ui_left"):
		direction -= 1

	if Input.is_action_pressed("right") or Input.is_action_pressed("ui_right"):
		direction += 1

	if direction != 0:
		velocity.x = direction * SPEED
	else:
		animation.play("IDLE")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	update_animation()
	move_and_slide()
	
	if position.y >= 950:
		die()
	
func update_animation():
	
	if velocity.x != 0:
		animation.play("RUN")
		
	else:
		animation.play("IDLE")
		
	if velocity.y < 0:
		animation.play("JUMP")
		
	if velocity.y > 0:
		animation.play("FALL")
		
func die():
	GameManager.respawn_player()
