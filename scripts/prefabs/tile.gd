extends Node3D

@export
var owner_name: String = ""
@export
var area_name: String = ""
@export
var level: int = 0
@export
var mortgaged: bool = false
@export
var group: int = 0
@export
var level_fee: int = 0
@export
var toll_fee: int = 0

var area: Area3D
var label_owner: Label3D
var label_area: Label3D
var levels: Node3D
var label_title: Label
var label_description: Label
var button_mortgage: Button
var control: Control

var player_states: Dictionary
var purchase_prices: Array
var toll_fees: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	self.label_owner = self.get_node("Owner")
	self.label_area = self.get_node("Title")
	self.levels = self.get_node("Level")
	self.label_title = self.get_node("Control/Card/Title")
	self.label_description = self.get_node("Control/Card/Description")
	self.button_mortgage = self.get_node("Control/Mortgage")
	self.control = self.get_node("Control")
	self.area = self.get_node("Area3D")
	self.control.visible = false
	if !self.multiplayer.is_server():
		self.area.body_entered.connect(_player_entered)
		self.area.body_exited.connect(_player_exited)
	else:
		self.level_fee = self.purchase_prices[self.level]
		self.toll_fee = self.toll_fees[self.level]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if self.multiplayer.is_server():
		return

	if self.area_name != "":
		var name_text = self.area_name
		var description = ""
		if mortgaged:
			name_text += "[*]"
			description += "[*]抵押\n"

		self.label_owner.text = self.owner_name
		self.label_area.text = name_text
		if self.control.visible:
			description += "主人: {0}\n".format([self.owner_name])
			description += "等级: {0}\n".format([self.level])
			description += "地产组: {0}\n".format([self.group])
			description += "购买/升级: ${0}\n".format([self.level_fee])
			description += "过路费: ${0}\n".format([self.toll_fee])
			if self.mortgaged:
				self.button_mortgage.text = "赎回"
			else:
				self.button_mortgage.text = "抵押"
			self.label_title.text = name_text
			self.label_description.text = description


	for i in range(1, 4):
		var level_room: Node3D = self.levels.get_node("Level"+str(i))
		if i <= self.level:
			level_room.visible = true
		else:
			level_room.visible = false


func _player_entered(body: Node3D):
	if self.multiplayer.get_unique_id() == body.get_multiplayer_authority():
		self.control.visible = true

func _player_exited(body: Node3D):
	if self.multiplayer.get_unique_id() == body.get_multiplayer_authority():
		self.control.visible = false

func _on_buy_button_up():
	rpc_id(1, "buy", self.multiplayer.get_unique_id())

func _on_upgrade_button_up():
	rpc_id(1, "upgrade", self.multiplayer.get_unique_id())

func _on_downgrade_button_up():
	rpc_id(1, "downgrade", self.multiplayer.get_unique_id())

func _on_mortgage_button_up():
	if self.mortgaged:
		rpc_id(1, "redeem", self.multiplayer.get_unique_id())
	else:
		rpc_id(1, "mortgage", self.multiplayer.get_unique_id())

@rpc("any_peer", "call_remote", "reliable")
func buy(peer_id: int):
	var player = self.player_states[peer_id]
	self.owner_name = player.name
	print(peer_id, player)

@rpc("any_peer", "call_remote", "reliable")
func upgrade(peer_id: int):
	var player = self.player_states[peer_id]
	if self.owner_name != player.name:
		return
	if self.level + 1 < self.purchase_prices.size():
		self.level += 1
	self.level_fee = self.purchase_prices[self.level]
	self.toll_fee = self.toll_fees[self.level]

@rpc("any_peer", "call_remote", "reliable")
func downgrade(peer_id: int):
	var player = self.player_states[peer_id]
	if self.owner_name != player.name:
		return
	if self.level > 0:
		self.level -= 1
	self.level_fee = self.purchase_prices[self.level]
	self.toll_fee = self.toll_fees[self.level]

@rpc("any_peer", "call_remote", "reliable")
func mortgage(peer_id: int):
	var player = self.player_states[peer_id]
	if self.owner_name != player.name:
		return
	self.mortgaged = true

@rpc("any_peer", "call_remote", "reliable")
func redeem(peer_id: int):
	var player = self.player_states[peer_id]
	if self.owner_name != player.name:
		return
	self.mortgaged = false



