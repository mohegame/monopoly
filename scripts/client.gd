extends Node3D

var camera: Node3D
var camera_yaw_angle: float = 0
var camera_pitch_angle: float = 0
var camera_original_position: Vector3 = Vector3(0, 2, 3.5)
var camera_current_position: Vector3 = self.camera_original_position
var connected = false
var player: Player
var button_voice: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.camera = self.get_node("../Camera")

	var peer = ENetMultiplayerPeer.new()
	peer.create_client("127.0.0.1",19979)
	self.multiplayer.connected_to_server.connect(self.connected_to_server)
	self.multiplayer.connection_failed.connect(self.failed_to_connect_to_server)
	self.multiplayer.multiplayer_peer = peer
	self.get_node("../Players/MultiplayerSpawner").spawned.connect(_spawned_player)
	button_voice = self.get_node("../Control/Voice")
	button_voice.button_up.connect(_voice_toogle)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !connected:
		return

	if !self.multiplayer.has_multiplayer_peer() || self.multiplayer.is_server():
		return
	
	var uid = self.multiplayer.multiplayer_peer.get_unique_id()

	if self.player == null:
		self.player = self.get_node_or_null("../Players/" + str(uid))
		if player == null:
			return
		
		var voice_capture = self.get_node("../VoiceCapture")
		self.player.voice_capture = voice_capture


	var input_dir := Input.get_vector("look_left", "look_right", "look_up", "look_down")
	if input_dir.length() > 0:
		if input_dir.x != 0:
			self.camera_yaw_angle += input_dir.x * delta * PI/2
			if self.camera_yaw_angle > PI * 2:
				self.camera_yaw_angle -= PI * 2 
			if self.camera_yaw_angle < PI * 2:
				self.camera_yaw_angle += PI * 2 
		if input_dir.y != 0:
			self.camera_pitch_angle += input_dir.y * delta * PI/2
			if self.camera_pitch_angle > PI/6:
				self.camera_pitch_angle = PI/6;
			if self.camera_pitch_angle < -PI/6:
				self.camera_pitch_angle = -PI/6;

		var camera_transform = Transform3D.IDENTITY.rotated(Vector3.RIGHT, self.camera_pitch_angle).rotated(Vector3.UP, self.camera_yaw_angle)
		self.camera_current_position = camera_transform.basis * camera_original_position
		self.player.forward_yaw_angle = camera_yaw_angle

	
	self.camera.position = self.player.position + self.camera_current_position
	self.camera.look_at(self.player.position)
func connected_to_server():
	connected = true
	print("Connected to server")


func failed_to_connect_to_server():
	connected = false
	print("Failed to connect to server")

func _spawned_player(node: Node3D):
	print("Spawned node: ", node.name)
	return

func _voice_toogle():
	if self.player == null:
		return

	self.player.voice_enabled = !self.player.voice_enabled
	if self.player.voice_enabled:
		self.button_voice.text = "?????????????????????"
	else:
		self.button_voice.text = "?????????????????????"
