extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var _dragging := false
var _button_index = null

const _MOVE_SENS := 0.01
const _ROTATE_SENS := 0.1
const _ZOOM_SENS := 0.1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_DOWN:
			self.translate(Vector3(0, 0, _ZOOM_SENS))
		elif event.button_index == BUTTON_WHEEL_UP:
			self.translate(Vector3(0, 0, -_ZOOM_SENS))
		
		if event.pressed and not _dragging:
			_dragging = true
		elif not event.pressed and _dragging:
			_dragging = false
			
		_button_index = event.button_index
		return
			
	if event is InputEventMouseMotion and _dragging:
		if _button_index == BUTTON_LEFT:
			self.translate(Vector3(event.relative.x * _MOVE_SENS, event.relative.y * _MOVE_SENS, 0))
		elif _button_index == BUTTON_RIGHT:
			self.rotate_x(deg2rad(-event.relative.y * _ROTATE_SENS))
			self.rotate_y(deg2rad(-event.relative.x * _ROTATE_SENS))
			
			
