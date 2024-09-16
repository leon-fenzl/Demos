extends Control
class_name PlayerHUD
@onready var player : Node
@onready var lifeBar := $LifeBar
@onready var label := $Label
static var coinLabel : Label
static var coinCounter : int
@onready var labelSettings : LabelSettings
func _ready():
	coinLabel = label
static func Register_Coins(coinValue:int):
	coinCounter += 1 * coinValue
	coinLabel.text = str(coinCounter)
func TextBurp():
	var tween = create_tween()
	labelSettings = labelSettings.new()
