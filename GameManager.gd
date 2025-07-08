extends Node

@export var stone_scene: PackedScene
@onready var timer: Timer = $Timer
@onready var increase_spawn_timer: Timer = $IncreaseSpawnTimer
@onready var score_label = $"../UI/ScoreLabel"

var score: int = 0
var is_game_over: bool = false
var stone_spawn_count: int = 1  

func _ready():
	if timer:
		timer.timeout.connect(spawn_stone)
		timer.start()
	else:
		print("Error: Timer tidak ditemukan!")

	# Pastikan IncreaseSpawnTimer ada sebelum digunakan
	if increase_spawn_timer:
		increase_spawn_timer.timeout.connect(_on_IncreaseSpawnTimer_timeout)
		increase_spawn_timer.start()
	else:
		print("Error: IncreaseSpawnTimer tidak ditemukan!")

func spawn_stone():
	if is_game_over:
		return
	
	for i in range(stone_spawn_count):
		if stone_scene:
			var stone = stone_scene.instantiate()
			stone.position = Vector2(randi_range(100, 800), 0)
			get_tree().current_scene.add_child(stone)

func add_score():
	if not is_game_over:
		score += 1
		score_label.text = "Score: " + str(score)

func stop_game():
	is_game_over = true
	timer.stop()
	if increase_spawn_timer:
		increase_spawn_timer.stop()  # Hentikan penambahan batu saat game over
	stop_all_stones()

func stop_all_stones():
	var stones = get_tree().get_nodes_in_group("stones")
	for stone in stones:
		if stone is RigidBody2D:
			stone.freeze = true
			stone.linear_velocity = Vector2.ZERO

func _on_IncreaseSpawnTimer_timeout():
	if not is_game_over:
		stone_spawn_count += 1  
		if timer:
			timer.wait_time = max(0.5, timer.wait_time * 0.9)  
		print("Batu lebih banyak! Sekarang spawn", stone_spawn_count, "batu per waktu.")
