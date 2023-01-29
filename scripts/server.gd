extends Node

var move_speed: float = 10
var camera: Node3D
var players: Node3D
var player_controllers: Node3D
var game_objects: Node3D 
var game: Node3D

var player_count = 0
var game_state: Dictionary
var offline_player_states: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.camera = self.get_node("../Camera")
	self.camera.rotation = Vector3(-PI/4, PI/2, 0)
	self.camera.position = Vector3(20, 10, 0)
	self.players = self.get_node("../Players")
	self.player_controllers = self.get_node("../PlayerControllers")
	self.game_objects = self.get_node("../GameObjects")

	var peer = ENetMultiplayerPeer.new()
	self.multiplayer.peer_connected.connect(self.add_player)
	self.multiplayer.peer_disconnected.connect(self.remove_player)
	peer.create_server(19979, 10)
	self.multiplayer.multiplayer_peer = peer
	print("Server started at 19979")

	#self.game = preload("res://game.tscn").instantiate()
	#self.get_parent().add_child(self.game)
	var tile_class = preload("res://scenes/prefabs/tile.tscn")
	var random_class = preload("res://scenes/prefabs/random.tscn")
	var placeholder_class = preload("res://scenes/prefabs/placeholder.tscn")
	var random_card_class = preload("res://scenes/prefabs/random_card.tscn")
	var bank_class = preload("res://scenes/prefabs/bank.tscn")

	var game_tile_data = GameTileData.new()
	for item in game_tile_data.data:
		var width = game_tile_data.chess_board.width * game_tile_data.chess_board.side_length
		var height = game_tile_data.chess_board.height * game_tile_data.chess_board.side_length
		var x = item.position.x * game_tile_data.chess_board.side_length - width / 2
		var z = -(item.position.y * game_tile_data.chess_board.side_length - height / 2)
		var y_ratation = 0
		match item.orientation:
			GameTileData.ORIENTATION_NORTH:
				y_ratation = 0
			GameTileData.ORIENTATION_EAST:
				y_ratation = - PI / 2
			GameTileData.ORIENTATION_SOUTH:
				y_ratation = - PI
			GameTileData.ORIENTATION_WEST:
				y_ratation = - PI * 3 / 2

		match item.kind:
			GameTileData.DATA_KIND_COUNTRY:
				var object = tile_class.instantiate()
				object.position = Vector3(x, 0, z)
				object.rotate_y(y_ratation)
				object.area_name = item.name
				object.group = item.group
				object.purchase_prices = item.purchase_price
				object.toll_fees = item.toll_fee
				object.level = 0
				object.player_states = self.game_state
				self.game_objects.add_child(object, true)
			GameTileData.DATA_KIND_CHANCE:
				var object: Node3D = random_card_class.instantiate()
				object.position = Vector3(x, 0, z)
				object.rotate_y(y_ratation)
				object.area_name = item.name
				object.area_description = item.description
				object.cards = game_tile_data.chance_cards
				self.game_objects.add_child(object, true)
			GameTileData.DATA_KIND_DESTINY:
				var object: Node3D = random_card_class.instantiate()
				object.position = Vector3(x, 0, z)
				object.rotate_y(y_ratation)
				object.area_name = item.name
				object.area_description = item.description
				object.cards = game_tile_data.destiny_cards
				self.game_objects.add_child(object, true)
			GameTileData.DATA_KIND_PLACEHOLDER:
				var object: Node3D = placeholder_class.instantiate()
				object.position = Vector3(x, 0, z)
				object.rotate_y(y_ratation)
				object.area_name = item.name
				object.area_description = item.description
				self.game_objects.add_child(object, true)
			GameTileData.DATA_KIND_RANDOM:
				var object: Node3D = random_class.instantiate()
				object.position = Vector3(x, 0, z)
				object.rotate_y(y_ratation)
				self.game_objects.add_child(object, true)
			GameTileData.DATA_KIND_BANK:
				var object: Node3D = bank_class.instantiate()
				object.position = Vector3(x, 0, z)
				object.rotate_y(y_ratation)
				object.player_states = self.game_state
				self.game_objects.add_child(object, true)


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

	var player_state = Dictionary()
	player_state.name = ""
	player_state.id = id
	player_state.score = 10000
	self.game_state[id] = player_state

	var player_controller = preload("res://scenes/prefabs/player_controller.tscn").instantiate()
	player_controller.name = str(id)
	player_controller.player_index = self.player_count
	player_controller.owner_id = id
	player_controller.player_state = player_state
	player_controller.player_states = self.game_state
	player_controller.offline_player_states = self.offline_player_states
	self.player_controllers.add_child(player_controller)

func remove_player(id: int):
	var player_controller = self.player_controllers.get_node(str(id))
	if player_controller:
		player_controller.queue_free()

	var player_state = self.game_state.get(id)
	if player_state != null:
		offline_player_states[player_state.name] = player_state
		self.game_state.erase(id)

	print("Client ", id, " disconnected")
