extends CanvasLayer


func _ready():
	GameManager.gained_coins.connect(update_coins_display)

func update_coins_display(gained_coins):
	$CoinDisplay.text = str(GameManager.coins)
