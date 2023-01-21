extends Object
class_name GameTileData

# Data kinds
const DATA_KIND_PLACEHOLDER = "Placeholder"
const DATA_KIND_COUNTRY = "Country"
const DATA_KIND_DESTINY = "Destiny"
const DATA_KIND_CHANCE = "Chance"
const DATA_KIND_RANDOM = "Random"


# Orientations
const ORIENTATION_EAST = "East"
const ORIENTATION_SOUTH = "South"
const ORIENTATION_WEST = "West"
const ORIENTATION_NORTH = "North"


var chess_board = {
	"width": 9,
	"height": 9,
	"side_length": 2,
}

var data: Array = [
	{
		"kind": DATA_KIND_PLACEHOLDER,
		"name": "起点",
		"position": Vector2(8, 0),
		"orientation": ORIENTATION_NORTH,
		"description": "经过此处时可获得奖金 $2000\n停留在此处可获得奖金 $4000",
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "美国",
		"position": Vector2(7, 0),
		"orientation": ORIENTATION_NORTH,
		"description": "",
		"group": 1,
		"purchase_price": [3000, 2000, 2000, 2000],
		"toll_fee": [300, 1500, 3500, 5000],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "美国",
		"position": Vector2(6, 0),
		"orientation": ORIENTATION_NORTH,
		"description": "",
		"group": 1,
		"purchase_price": [3000, 2000, 2000, 2000],
		"toll_fee": [300, 1500, 3500, 5000],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "美国",
		"position": Vector2(5, 0),
		"orientation": ORIENTATION_NORTH,
		"description": "",
		"group": 1,
		"purchase_price": [3000, 2000, 2000, 2000],
		"toll_fee": [300, 1500, 3500, 5000],
	},
	{
		"kind": DATA_KIND_DESTINY,
		"name": "命运",
		"position": Vector2(4, 0),
		"orientation": ORIENTATION_NORTH,
		"description": "抽取一张命运卡",
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "美国",
		"position": Vector2(3, 0),
		"orientation": ORIENTATION_NORTH,
		"description": "",
		"group": 2,
		"purchase_price": [3000, 2000, 2000, 2000],
		"toll_fee": [300, 1500, 3500, 5000],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "美国",
		"position": Vector2(2, 0),
		"orientation": ORIENTATION_NORTH,
		"description": "",
		"group": 2,
		"purchase_price": [3000, 2000, 2000, 2000],
		"toll_fee": [300, 1500, 3500, 5000],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "美国",
		"position": Vector2(1, 0),
		"orientation": ORIENTATION_NORTH,
		"description": "",
		"group": 2,
		"purchase_price": [3000, 2000, 2000, 2000],
		"toll_fee": [300, 1500, 3500, 5000],
	},



	{
		"kind": DATA_KIND_PLACEHOLDER,
		"name": "太平洋",
		"position": Vector2(0, 0),
		"orientation": ORIENTATION_EAST,
		"description": "停留在此处时停一轮",
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "美国",
		"position": Vector2(0, 1),
		"orientation": ORIENTATION_EAST,
		"description": "",
		"group": 3,
		"purchase_price": [3000, 2000, 2000, 2000],
		"toll_fee": [300, 1500, 3500, 5000],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "美国",
		"position": Vector2(0, 2),
		"orientation": ORIENTATION_EAST,
		"description": "",
		"group": 3,
		"purchase_price": [3000, 2000, 2000, 2000],
		"toll_fee": [300, 1500, 3500, 5000],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "美国",
		"position": Vector2(0, 3),
		"orientation": ORIENTATION_EAST,
		"description": "",
		"group": 3,
		"purchase_price": [3000, 2000, 2000, 2000],
		"toll_fee": [300, 1500, 3500, 5000],
	},
	{
		"kind": DATA_KIND_CHANCE,
		"name": "机会",
		"position": Vector2(0, 4),
		"orientation": ORIENTATION_EAST,
		"description": "",
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "美国",
		"position": Vector2(0, 5),
		"orientation": ORIENTATION_EAST,
		"description": "",
		"group": 4,
		"purchase_price": [3000, 2000, 2000, 2000],
		"toll_fee": [300, 1500, 3500, 5000],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "美国",
		"position": Vector2(0, 6),
		"orientation": ORIENTATION_EAST,
		"description": "",
		"group": 4,
		"purchase_price": [3000, 2000, 2000, 2000],
		"toll_fee": [300, 1500, 3500, 5000],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "美国",
		"position": Vector2(0, 7),
		"orientation": ORIENTATION_EAST,
		"description": "",
		"group": 4,
		"purchase_price": [3000, 2000, 2000, 2000],
		"toll_fee": [300, 1500, 3500, 5000],
	},




	{
		"kind": DATA_KIND_PLACEHOLDER,
		"name": "大西洋",
		"position": Vector2(0, 8),
		"orientation": ORIENTATION_SOUTH,
		"description": "停留在此处时停一轮",
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "美国",
		"position": Vector2(1, 8),
		"orientation": ORIENTATION_SOUTH,
		"description": "",
		"group": 5,
		"purchase_price": [3000, 2000, 2000, 2000],
		"toll_fee": [300, 1500, 3500, 5000],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "美国",
		"position": Vector2(2, 8),
		"orientation": ORIENTATION_SOUTH,
		"description": "",
		"group": 5,
		"purchase_price": [3000, 2000, 2000, 2000],
		"toll_fee": [300, 1500, 3500, 5000],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "美国",
		"position": Vector2(3, 8),
		"orientation": ORIENTATION_SOUTH,
		"description": "",
		"group": 5,
		"purchase_price": [3000, 2000, 2000, 2000],
		"toll_fee": [300, 1500, 3500, 5000],
	},
	{
		"kind": DATA_KIND_DESTINY,
		"name": "命运",
		"position": Vector2(4, 8),
		"orientation": ORIENTATION_SOUTH,
		"description": "",
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "美国",
		"position": Vector2(5, 8),
		"orientation": ORIENTATION_SOUTH,
		"description": "",
		"group": 6,
		"purchase_price": [3000, 2000, 2000, 2000],
		"toll_fee": [300, 1500, 3500, 5000],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "美国",
		"position": Vector2(6, 8),
		"orientation": ORIENTATION_SOUTH,
		"description": "",
		"group": 6,
		"purchase_price": [3000, 2000, 2000, 2000],
		"toll_fee": [300, 1500, 3500, 5000],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "美国",
		"position": Vector2(7, 8),
		"orientation": ORIENTATION_SOUTH,
		"description": "",
		"group": 6,
		"purchase_price": [3000, 2000, 2000, 2000],
		"toll_fee": [300, 1500, 3500, 5000],
	},



	{
		"kind": DATA_KIND_PLACEHOLDER,
		"name": "北冰洋",
		"position": Vector2(8, 8),
		"orientation": ORIENTATION_WEST,
		"description": "停留在此处时停一轮",
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "美国",
		"position": Vector2(8, 7),
		"orientation": ORIENTATION_WEST,
		"description": "",
		"group": 7,
		"purchase_price": [3000, 2000, 2000, 2000],
		"toll_fee": [300, 1500, 3500, 5000],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "美国",
		"position": Vector2(8, 6),
		"orientation": ORIENTATION_WEST,
		"description": "",
		"group": 7,
		"purchase_price": [3000, 2000, 2000, 2000],
		"toll_fee": [300, 1500, 3500, 5000],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "美国",
		"position": Vector2(8, 5),
		"orientation": ORIENTATION_WEST,
		"description": "",
		"group": 7,
		"purchase_price": [3000, 2000, 2000, 2000],
		"toll_fee": [300, 1500, 3500, 5000],
	},
	{
		"kind": DATA_KIND_CHANCE,
		"name": "机会",
		"position": Vector2(8, 4),
		"orientation": ORIENTATION_WEST,
		"description": "",
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "美国",
		"position": Vector2(8, 3),
		"orientation": ORIENTATION_WEST,
		"description": "",
		"group": 8,
		"purchase_price": [3000, 2000, 2000, 2000],
		"toll_fee": [300, 1500, 3500, 5000],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "美国",
		"position": Vector2(8, 2),
		"orientation": ORIENTATION_WEST,
		"description": "",
		"group": 8,
		"purchase_price": [3000, 2000, 2000, 2000],
		"toll_fee": [300, 1500, 3500, 5000],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "美国",
		"position": Vector2(8, 1),
		"orientation": ORIENTATION_WEST,
		"description": "",
		"group": 8,
		"purchase_price": [3000, 2000, 2000, 2000],
		"toll_fee": [300, 1500, 3500, 5000],
	},
	
	{
		"kind": DATA_KIND_RANDOM,
		"name": "骰子",
		"position": Vector2(4, 4),
		"orientation": ORIENTATION_SOUTH,
		"description": "",
	}
]
