extends StaticBody2D

func _on_body_entered(body):
	if body.name == "Stone":
		get_parent().get_node("GameManager").add_score() # Tambah skor jika batu terhindar
		body.queue_free() # Hapus batu saat menyentuh tanah
