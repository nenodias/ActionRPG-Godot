extends MarginContainer


onready var newGameBtn = $HBoxContainer/VBoxContainer/NewGame
onready var continueBtn = $HBoxContainer/VBoxContainer/Continue
onready var quitBtn = $HBoxContainer/VBoxContainer/Quit

var activeOption = 0 setget setActiveOption
var options = []

# Called when the node enters the scene tree for the first time.
func _ready():
	options = [newGameBtn, continueBtn, quitBtn]
	newGameBtn.connect("gui_input", self, 'new_game_event')
	continueBtn.connect("gui_input", self, 'continue_event')
	quitBtn.connect("gui_input", self, 'quit_event')
	
	activeOption = 0

func setActiveOption(value):
	if value > 2:
		activeOption = value % 3
	elif value < 0:
		activeOption = value + 3
	else:
		activeOption = value
	for i in range(len(options)):
		var material = options[i].get_material()
		material.set_shader_param("active", false)
	var material = options[activeOption].get_material()
	material.set_shader_param("active", true)


func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		self.activeOption -= 1
	if Input.is_action_just_pressed("ui_down"):
		self.activeOption += 1
	if Input.is_action_just_pressed("ui_accept"):
		var btn = options[activeOption]
		btn.emit_signal('gui_input', 'click')

func new_game_event(event):
	if event == 'click':
		get_tree().change_scene("res://World.tscn")
	
func continue_event(event):
	if event == 'click':
		pass
	
func quit_event(event):
	if event == 'click':
		get_tree().quit()
