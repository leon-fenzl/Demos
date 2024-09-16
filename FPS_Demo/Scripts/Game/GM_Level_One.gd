extends GameManager
@export_group("Game Global Static Variables")
enum COLLECTABLES{COINS,MIMICS,MARKERS}
static var playerHud : Control
static var collect_type : COLLECTABLES
static var defeated_count : int = 0
static var player_is_dead : bool = false
static var coins := 0
func _ready():
	Game_Start()
func _physics_process(delta):
	Custom_Timer(delta)
