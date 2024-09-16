extends Resource
class_name Utilities
static func Set_Lifebar(barNode:ProgressBar,endValue:float):
	barNode.value = endValue
static func Register_Coins(counter:int,coinValue:int,writer:TextLine):
	counter += 1
	writer.set_text(str(counter))
	return counter
static func GetPlayer(player:Node):
	return player
static func Respawn():
	pass
