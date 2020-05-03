extends AudioStreamPlayer

func _ready():
	var _bind = connect("finished", self, "queue_free")
