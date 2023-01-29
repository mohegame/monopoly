extends Object
class_name GameTileData

# Data kinds
const DATA_KIND_PLACEHOLDER = "Placeholder"
const DATA_KIND_COUNTRY = "Country"
const DATA_KIND_DESTINY = "Destiny"
const DATA_KIND_CHANCE = "Chance"
const DATA_KIND_RANDOM = "Random"
const DATA_KIND_BANK = "Bank"


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
		"name": "中国",
		"position": Vector2(7, 0),
		"orientation": ORIENTATION_NORTH,
		"description": "",
		"group": 1,
		"purchase_price": [4000, 2000, 2000, 2000],
		"toll_fee": [180, 2000, 6000, 14000],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "日本",
		"position": Vector2(6, 0),
		"orientation": ORIENTATION_NORTH,
		"description": "",
		"group": 1,
		"purchase_price": [1000, 500, 500, 500],
		"toll_fee": [60, 300, 900, 2700],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "韩国",
		"position": Vector2(5, 0),
		"orientation": ORIENTATION_NORTH,
		"description": "",
		"group": 1,
		"purchase_price": [1000, 500, 500, 500],
		"toll_fee": [60, 300, 900, 2700],
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
		"name": "菲律宾",
		"position": Vector2(3, 0),
		"orientation": ORIENTATION_NORTH,
		"description": "",
		"group": 2,
		"purchase_price": [600, 500, 500, 500],
		"toll_fee": [40, 200, 600, 1800],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "越南",
		"position": Vector2(2, 0),
		"orientation": ORIENTATION_NORTH,
		"description": "",
		"group": 2,
		"purchase_price": [2800, 1500, 1500, 1500],
		"toll_fee": [220, 1200, 3600, 8500],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "马来西亚",
		"position": Vector2(1, 0),
		"orientation": ORIENTATION_NORTH,
		"description": "",
		"group": 2,
		"purchase_price": [2600, 1500, 1500, 1500],
		"toll_fee": [220, 1100, 3300, 8000],
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
		"name": "埃及",
		"position": Vector2(0, 1),
		"orientation": ORIENTATION_EAST,
		"description": "",
		"group": 3,
		"purchase_price": [1800, 1000, 1000, 1000],
		"toll_fee": [140, 700, 2000, 5500],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "赞比亚",
		"position": Vector2(0, 2),
		"orientation": ORIENTATION_EAST,
		"description": "",
		"group": 3,
		"purchase_price": [600, 500, 500, 500],
		"toll_fee": [20, 100, 300, 900],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "摩洛哥",
		"position": Vector2(0, 3),
		"orientation": ORIENTATION_EAST,
		"description": "",
		"group": 3,
		"purchase_price": [1800, 1000, 1000, 1000],
		"toll_fee": [140, 700, 2000, 5500],
	},
	{
		"kind": DATA_KIND_CHANCE,
		"name": "机会",
		"position": Vector2(0, 4),
		"orientation": ORIENTATION_EAST,
		"description": "抽取一张机会卡",
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "土耳其",
		"position": Vector2(0, 5),
		"orientation": ORIENTATION_EAST,
		"description": "",
		"group": 4,
		"purchase_price": [3500, 2000, 2000, 2000],
		"toll_fee": [350, 1750, 5000, 11000],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "叙利亚",
		"position": Vector2(0, 6),
		"orientation": ORIENTATION_EAST,
		"description": "",
		"group": 4,
		"purchase_price": [3500, 2000, 2000, 2000],
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
		"toll_fee": [350, 1750, 5000, 11000],
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
		"name": "法国",
		"position": Vector2(1, 8),
		"orientation": ORIENTATION_SOUTH,
		"description": "",
		"group": 5,
		"purchase_price": [3000, 2000, 2000, 2000],
		"toll_fee": [260, 1300, 3900, 9000],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "瑞士",
		"position": Vector2(2, 8),
		"orientation": ORIENTATION_SOUTH,
		"description": "",
		"group": 5,
		"purchase_price": [3200, 2000, 2000, 2000],
		"toll_fee": [280, 1500, 4500, 10000],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "比利时",
		"position": Vector2(3, 8),
		"orientation": ORIENTATION_SOUTH,
		"description": "",
		"group": 5,
		"purchase_price": [2200, 1500, 1500, 1500],
		"toll_fee": [180, 900, 2500, 7000],
	},
	{
		"kind": DATA_KIND_DESTINY,
		"name": "命运",
		"position": Vector2(4, 8),
		"orientation": ORIENTATION_SOUTH,
		"description": "抽取一张命运卡",
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "古巴",
		"position": Vector2(5, 8),
		"orientation": ORIENTATION_SOUTH,
		"description": "",
		"group": 6,
		"purchase_price": [3000, 2000, 2000, 2000],
		"toll_fee": [260, 1300, 3900, 9000],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "哥斯达黎加",
		"position": Vector2(6, 8),
		"orientation": ORIENTATION_SOUTH,
		"description": "",
		"group": 6,
		"purchase_price": [1000, 500, 500, 500],
		"toll_fee": [60, 300, 900, 2700],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "巴拿马",
		"position": Vector2(7, 8),
		"orientation": ORIENTATION_SOUTH,
		"description": "",
		"group": 6,
		"purchase_price": [3200, 2000, 2000, 2000],
		"toll_fee": [280, 1500, 4500, 10000],
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
		"name": "加拿大",
		"position": Vector2(8, 7),
		"orientation": ORIENTATION_WEST,
		"description": "",
		"group": 7,
		"purchase_price": [3500, 2000, 2000, 2000],
		"toll_fee": [350, 1750, 5000, 11000],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "墨西哥",
		"position": Vector2(8, 6),
		"orientation": ORIENTATION_WEST,
		"description": "",
		"group": 7,
		"purchase_price": [1000, 500, 500, 500],
		"toll_fee": [60, 300, 900, 2700],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "美国",
		"position": Vector2(8, 5),
		"orientation": ORIENTATION_WEST,
		"description": "",
		"group": 7,
		"purchase_price": [3500, 2000, 2000, 2000],
		"toll_fee": [350, 1750, 5000, 11000],
	},
	{
		"kind": DATA_KIND_CHANCE,
		"name": "机会",
		"position": Vector2(8, 4),
		"orientation": ORIENTATION_WEST,
		"description": "抽取一张机会卡",
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "波兰",
		"position": Vector2(8, 3),
		"orientation": ORIENTATION_WEST,
		"description": "",
		"group": 8,
		"purchase_price": [1200, 500, 500, 500],
		"toll_fee": [80, 400, 1000, 3000],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "俄罗斯",
		"position": Vector2(8, 2),
		"orientation": ORIENTATION_WEST,
		"description": "",
		"group": 8,
		"purchase_price": [1000, 500, 500, 500],
		"toll_fee": [60, 300, 900, 2700],
	},
	{
		"kind": DATA_KIND_COUNTRY,
		"name": "德国",
		"position": Vector2(8, 1),
		"orientation": ORIENTATION_WEST,
		"description": "",
		"group": 8,
		"purchase_price": [2400, 1500, 1500, 1500],
		"toll_fee": [200, 1000, 3000, 7500],
	},

	{
		"kind": DATA_KIND_RANDOM,
		"name": "骰子",
		"position": Vector2(4, 4),
		"orientation": ORIENTATION_SOUTH,
		"description": "",
	},
	{
		"kind": DATA_KIND_BANK,
		"name": "银行",
		"position": Vector2(5, 4),
		"orientation": ORIENTATION_SOUTH,
		"description": "交易",
	},
	{
		"kind": DATA_KIND_BANK,
		"name": "银行",
		"position": Vector2(3, 4),
		"orientation": ORIENTATION_NORTH,
		"description": "交易",
	},
]


var destiny_cards: Array = [
	{
		"name": "小赌怡情",
		"description": "打麻将输掉 $500",
	},
	{
		"name": "大赌伤身",
		"description": "在拉斯维加斯赌博输掉 $3000",
	},
	{
		"name": "送外卖",
		"description": "送外卖赚到 $500",
	},
	{
		"name": "外卖之星",
		"description": "送外卖业绩第一，奖励 $1500",
	},
	{
		"name": "见义勇为",
		"description": "路见不平一声吼，获得见义勇为奖励 $3000",
	},
	{
		"name": "奖学金",
		"description": "努力学习获得奖学金 $1500",
	},
	{
		"name": "机不可失",
		"description": "抽取 1 张机会卡",
	},
	{
		"name": "减肥计划",
		"description": "办理健身卡，花费 $2000",
	},
	{
		"name": "减肥成功",
		"description": "和健身教练对赌，减肥成功获得 $2000",
	},
	{
		"name": "减肥失败",
		"description": "和健身教练对赌，减肥失败，继续购买健身课程，花费 $2000",
	},
]

var chance_cards: Array = [
	{
		"name": "地产大亨",
		"description": "选择自己的 1 处地产，升 1 级",
	},
	{
		"name": "韭菜眼光",
		"description": "选择自己的 1 处地产，降 1 级",
	},
	{
		"name": "命中注定",
		"description": "抽取一张命运卡",
	},
	{
		"name": "航班延误",
		"description": "受到天气影响，航班延误，不能做任何事情，跳过下回合",
	},
	{
		"name": "一路畅通",
		"description": "路况良好，再摇 1 次骰子，继续前进",
	},
	{
		"name": "赌鬼",
		"description": "摇一次骰子，如果是偶数，选择自己的 1 处地产，升 1 级，如果是奇数，降 2 级",
	},
	{
		"name": "赌神",
		"description": "摇一次骰子，如果是偶数，选择自己的 1 处地产，升 2 级，如果是奇数，降 1 级",
	},
	{
		"name": "破坏王",
		"description": "摇一次骰子，如果是偶数，其他玩家每个人需要选择他们的 1 处地产，降 1 级",
	},
	{
		"name": "慈善家",
		"description": "摇一次骰子，如果是偶数，其他玩家每个人需要选择他们的 1 处地产，升 1 级",
	},
	{
		"name": "航空飞行",
		"description": "立即前往下个标记为命运的地点，但不再抽取命运卡",
	},
	{
		"name": "航天飞行",
		"description": "立即前往下个标记为机会的地点，但不再抽取机会卡",
	},
	{
		"name": "买错机票 1",
		"description": "前往起点",
	},
	{
		"name": "买错机票 2",
		"description": "前往太平洋",
	},
	{
		"name": "买错机票 3",
		"description": "前往大西洋",
	},
	{
		"name": "买错机票 4",
		"description": "前往北冰洋",
	},
	{
		"name": "没有机会",
		"description": "什么都没有发生",
	},
]
