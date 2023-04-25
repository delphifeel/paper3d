extends Label3D


const _default_text := "Move camera with mouse"
const _max_size_y := 2.8
var _text := ""
var _batched_text := ""


# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = _default_text

func _change_text(new_text):
	_text = new_text
	if new_text:
		self.text = new_text
	else:
		self.text = _default_text
		
func _no_more_space():
	var size := self.get_aabb().size
	return size.y >= _max_size_y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_BACKSPACE:
			_batched_text = _text.substr(0, _text.length() - 1)
			return
		
		var c = ""
		if event.unicode != 0:
			c = char(event.unicode)
		elif event.scancode < KEY_SPACE:
			c = char(event.scancode).to_lower()
		elif event.scancode == KEY_SPACE:
			c = " "		
			
		_batched_text = _text + c
		
func _process(delta):
	if _batched_text:
		_change_text(_batched_text)
		_batched_text = ""
	
	# fast fix for overflow
	if _no_more_space():
		var _new_text = self.text.substr(0, self.text.length() - 1)
		_change_text(_new_text)
				
				
