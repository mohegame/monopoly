extends Node

var move_speed: float = 10
var camera: Node3D
var players: Node3D
var game_objects: Node3D 
var game: Node3D

var player_count = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.camera = self.get_node("../Camera")
	self.camera.rotation = Vector3(-PI/4, PI/2, 0)
	self.camera.position = Vector3(20, 10, 0)
	self.players = self.get_node("../Players")
	self.game_objects = self.get_node("../GameObjects")

	var peer = ENetMultiplayerPeer.new()
	self.multiplayer.peer_connected.connect(self.add_player)
	self.multiplayer.peer_disconnected.connect(self.remove_player)
	peer.create_server(19979, 10)
	self.multiplayer.multiplayer_peer = peer
	print("Server started at 19979")

	#self.game = preload("res://game.tscn").instantiate()
	#self.get_parent().add_child(self.game)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Move freely.
	
	var value = Input.get_axis("move_right", "move_left")
	if value != 0:
		self.camera.position.z += delta * self.move_speed * value

	value = Input.get_axis("move_forward", "move_backward")
	if value != 0:
		self.camera.position.x += delta * self.move_speed * value

	if Input.is_action_pressed("move_up"):
		self.camera.position.y += delta * self.move_speed
	if Input.is_action_pressed("move_down"):
		self.camera.position.y -= delta * self.move_speed


func add_player(id: int):
	print("Client ", id, " connected")
	self.player_count += 1
	var positions = self.get_node("../StartPositions")
	var start_transform = positions.get_node("StartPosition" + str(self.player_count % positions.get_child_count())).transform

	var player = preload("res://scenes/prefabs/player.tscn").instantiate()
	player.name = str(id)
	player.transform = start_transform
	self.players.add_child(player)

	var pawn = preload("res://scenes/prefabs/pawn.tscn").instantiate()
	pawn.name = "pawn-" + str(id)
	pawn.transform = start_transform
	self.game_objects.add_child(pawn)



func remove_player(id: int):
	var player = self.players.get_node(str(id))
	if player:
		player.queue_free()
	print("Client ", id, " disconnected")
