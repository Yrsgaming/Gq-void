extends Camera2D

var pos_1 = Vector2(575,326)
var pos_2 = Vector2(1729,326)


func change_scene(scene):
	var tween = create_tween()
	if scene == 1:
		tween.tween_property(self,"position",pos_1,1)
	if scene == 2:
		tween.tween_property(self,"position",pos_2,1)
