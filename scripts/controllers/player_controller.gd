extends Node3D
class_name PlayerController

@export
var owner_id: int = 0

@export
var player_states: Dictionary
var player_state: Dictionary

var player_index = 0
var start_positions: Node3D
var players: Node3D
var game_objects: Node3D
var player: Player
var pawn: Node3D
var label_score: Label
var control: Control
var line_edit_player_name: LineEdit
var label_description: Label
var button_login: Button
var container_login_pane: VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	self.start_positions = self.get_node("../../StartPositions")
	self.players = self.get_node("../../Players")
	self.label_score = self.get_node("Control/Score")
	self.line_edit_player_name = self.get_node("Control/LoginPane/PlayerName")
	self.label_description = self.get_node("Control/LoginPane/Description")
	self.button_login = self.get_node("Control/LoginPane/Login")
	self.container_login_pane = self.get_node("Control/LoginPane")
	self.control = self.get_node("Control")
	self.game_objects = self.get_node("../../GameObjects")

	if self.multiplayer.is_server():
		var syncer: MultiplayerSynchronizer = self.get_node("MultiplayerSynchronizer")
		syncer.set_visibility_for(self.owner_id, true)
		self.control.visible = false
	else:
		self.control.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.owner_id != self.multiplayer.get_unique_id():
		return

	for id in self.player_states:
		if id == self.owner_id:
			self.label_score.text = "$" + str(self.player_states[id].score)


@rpc(authority, call_remote, reliable)
func initialize_player(player_name: String, player_transform: Transform3D):
	print(player_name, player_transform)
	self.player = self.players.get_node(str(self.multiplayer.get_unique_id()))
	self.player.transform = player_transform
	self.player.player_name = player_name
	self.player.initialize()
	self.container_login_pane.visible = false

@rpc(authority, call_remote, reliable)
func failed_to_add_player(message: String):
	self.label_description.text = message

@rpc(any_peer, call_remote, reliable)
func add_player(player_name: String):
	for i in self.player_states:
		var state = self.player_states[i]
		if state.name == player_name:
			rpc_id(self.owner_id, "failed_to_add_player", "Player name {0} already exists".format([player_name]))
			return
	self.player = preload("res://scenes/prefabs/player.tscn").instantiate()
	self.player.name = str(self.owner_id)
	self.players.add_child(player)

	self.pawn = preload("res://scenes/prefabs/pawn.tscn").instantiate()
	self.pawn.name = "pawn-" + str(self.owner_id)
	self.game_objects.add_child(pawn)

	self.player_state.name = player_name

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



func _on_score_button_up():
	pass # Replace with function body.
