extends CharacterBody2D

@export var speed: int = 300  # Kecepatan gerak
@export var max_hp: int = 3   # HP maksimum

var hp: int
@onready var hp_label = get_parent().get_node_or_null("UI/HPLabel")
@onready var game_over_screen = get_parent().get_node_or_null("UI/GameOverScreen")

func _ready():
	hp = max_hp
	update_hp_label()

func _process(delta):
	if hp > 0:
		var direction = Input.get_axis("move_left", "move_right")
		velocity.x = direction * speed
		move_and_slide()

func take_damage():
	hp -= 1
	update_hp_label()
	print("HP Player:", hp)

	if hp <= 0:
		game_over()

func game_over():
	print("Game Over!")  
	if game_over_screen:
		game_over_screen.visible = true  

	# Panggil fungsi di GameManager untuk menghentikan batu dan timer
	var game_manager = get_tree().get_first_node_in_group("GameManager")
	if game_manager:
		game_manager.stop_game()

	set_process(false)  # Hentikan proses input player
	velocity = Vector2.ZERO

func update_hp_label():
	if hp_label:
		hp_label.text = "HP: " + str(hp)
