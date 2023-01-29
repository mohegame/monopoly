extends Node3D
class_name PlayerController

@export
var owner_id: int = 0

@export
var player_states: Dictionary
var player_state: Dictionary
var offline_player_states: Dictionary

var player_index = 0
var start_positions: Node3D
var players: Node3D
var game_objects: Node3D
var player: Player
var pawn: Node3D
var button_score: MenuButton
var control: Control
var line_edit_player_name: LineEdit
var label_description: Label
var button_login: Button
var container_login_pane: VBoxContainer
var initialized: bool = false
var menu_items: Array
var button_lift: Button

# Called when the node enters the scene tree for the first time.
func _ready():
	self.start_positions = self.get_node("../../StartPositions")
	self.players = self.get_node("../../Players")
	self.button_score = self.get_node("Control/Score")
	self.line_edit_player_name = self.get_node("Control/LoginPane/PlayerName")
	self.label_description = self.get_node("Control/LoginPane/Description")
	self.button_login = self.get_node("Control/LoginPane/Login")
	self.container_login_pane = self.get_node("Control/LoginPane")
	self.button_lift = self.get_node("Control/Lift")
	self.control = self.get_node("Control")
	self.game_objects = self.get_node("../../GameObjects")
	self.control.visible = false

	if self.multiplayer.is_server():
		var syncer: MultiplayerSynchronizer = self.get_node("MultiplayerSynchronizer")
		syncer.set_visibility_for(self.owner_id, true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if self.owner_id != self.multiplayer.get_unique_id():
		return

	self.control.visible = true
	self.button_score.visible = initialized
	self.container_login_pane.visible = !initialized

	var player_array = []
	for id in self.player_states:
		var a_player_state = self.player_states[id]
		player_array.push_back(a_player_state)
		if id == self.owner_id:
			self.button_score.text = "$" + str(self.player_states[id].score)
	
	player_array.sort_custom(
		func(a, b): return a.score > b.score
	)

	var player_names = []
	var player_names_dict = {}
	for item in player_array:
		if item.name == "":
			continue
		var player_name = "$%-10d%s" % [item.score, item.name]
		player_names.append(player_name)
		player_names_dict[player_name] = true

	if !(player_names.size() == self.menu_items.size() && player_names_dict.has_all(self.menu_items)):
		self.button_score.get_popup().clear()
		self.menu_items.clear()
		for player_name in player_names:
			self.menu_items.append(player_name)
			self.button_score.get_popup().add_item(player_name)



@rpc("authority", "call_remote", "reliable")
func initialize_player(player_name: String, player_transform: Transform3D):
	self.player = self.players.get_node(str(self.multiplayer.get_unique_id()))
	self.player.transform = player_transform
	self.player.player_name = player_name
	self.player.initialize()
	self.initialized = true

@rpc("authority", "call_remote", "reliable")
func failed_to_add_player(message: String):
	self.label_description.text = message

@rpc("any_peer", "call_remote", "reliable")
func add_player(player_name: String):
	print("Add Player ", player_name)
	for i in self.player_states:
		var state = self.player_states[i]
		if state.name == player_name:
			rpc_id(self.owner_id, "failed_to_add_player", "玩家名称 {0} 已存在".format([player_name]))
			return
	self.player = preload("res://scenes/prefabs/player.tscn").instantiate()
	self.player.name = str(self.owner_id)
	self.players.add_child(player)

	self.pawn = preload("res://scenes/prefabs/pawn.tscn").instantiate()
	self.pawn.name = "pawn-" + str(self.owner_id)
	self.game_objects.add_child(pawn)

	self.player_state.name = player_name
	var offline_player_state = self.offline_player_states.get(player_name)
	if offline_player_state != null:
		self.player_state.score = offline_player_state.score
		self.offline_player_states.erase(player_name)

	var position_index = self.player_index % self.start_positions.get_children().size()
	var transfrom = self.start_positions.get_node("StartPosition"+str(position_index)).transform
	rpc_id(self.owner_id, "initialize_player", player_name, transfrom)

func _exit_tree():
	if self.player != null:
		self.player.queue_free()

	if self.pawn != null:
		self.pawn.queue_free()


func _on_login_button_up():
	if self.line_edit_player_name.text == "":
		return
	rpc_id(1, "add_player", self.line_edit_player_name.text)


func _on_lift_button_up() -> void:
	self.player.toggle_attached_object()
	if self.player.attached_object == null:
		self.button_lift.text = "举起棋子"
	else:
		self.button_lift.text = "放下棋子"
