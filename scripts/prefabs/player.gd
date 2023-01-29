extends CharacterBody3D
class_name Player


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export
var initialized: bool = false

@export
var state: String = ""

@export
var player_name: String = ""

var forward_yaw_angle: float = 0
var player_id: int
var attached_object: Node3D
var animation_player: AnimationPlayer
var label_player_name: Label3D


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _init():
	self.visible = false

func initialize() -> void:
	self.initialized = true
	return

func _enter_tree() -> void:
	self.animation_player = self.get_node("Character/AnimationPlayer")
	self.player_id = str(self.name).to_int()
	self.set_multiplayer_authority(self.player_id)
	self.state = "Idle2"
	self.label_player_name = self.get_node("PlayerName")

func _physics_process(delta: float) -> void:
	if !self.initialized:
		return

	if !self.visible:
		self.visible = true

	if self.multiplayer.get_unique_id() != self.player_id:
		return

	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (Transform3D.IDENTITY.rotated(Vector3.UP, forward_yaw_angle) * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	if velocity.x == 0 and velocity.z == 0:
		self.state = "Idle2"
	else:
		self.state = "Run"

	if not direction.is_zero_approx():
		var rad = acos(Vector2(0, -1).dot(Vector2(direction.x, direction.z)))
		if direction.x > 0: 
			rad = -rad
		self.rotation = Vector3(0, rad, 0)

	move_and_slide()
	return

func _process(_delta: float) -> void:
	if !self.initialized:
		return

	if !self.visible:
		self.visible = true

	if self.attached_object != null:
		self.attached_object.position = self.position + Vector3(0,1.7,0)

	if self.animation_player.current_animation != self.state:
		self.animation_player.current_animation = self.state
	
	self.label_player_name.text = self.player_name

	if self.multiplayer.get_unique_id() != self.player_id:
		return

	if Input.is_action_just_pressed("attach_object"):
		self.toggle_attached_object()

func toggle_attached_object():
	if self.attached_object == null:
		rpc("attach_object", "pawn-" + str(self.player_id))
	else:
		rpc("detach_object", self.position)


@rpc("any_peer", "call_local", "reliable")
func attach_object(object_name: String):
	self.attached_object = self.get_node("../../GameObjects/"+object_name)
	return

@rpc("any_peer", "call_local", "reliable")
func detach_object(object_position: Vector3):
	self.attached_object.position = object_position
	self.attached_object = null
	return
