extends RigidBody2D

@export var fall_speed: int = 200  # Kecepatan jatuh batu

func _ready():
	add_to_group("stones")  # Tambahkan batu ke grup untuk kontrol Game Over
	linear_velocity = Vector2(0, fall_speed)  # Atur kecepatan jatuh batu
	$Area2D.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody2D:
		body.take_damage()  # Kurangi HP player
		queue_free()  # Hapus batu setelah mengenai player
	elif body.name == "Ground":
		var game_manager = get_tree().get_first_node_in_group("GameManager")
		if game_manager:
			game_manager.add_score()  # Tambah skor jika batu kena tanah
		queue_free()  # Hapus batu setelah menyentuh tanah
