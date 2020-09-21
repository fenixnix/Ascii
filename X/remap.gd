extends Node

class_name site_map

func remap(root:Node):
	var points = []
	for c in root.get_children():
		points.append(c)
	var new_points = []
	for p in points:
		var pts = nearst3points(p,points)
		if check_in_delta(p.position,pts):
			new_points.append(deltaCenter(pts))
		else:
			new_points.append(p.position)
	for i in range(root.get_child_count()):
		root.get_child(i).position = new_points[i]

func deltaCenter(delta):
	var sum:Vector2 = Vector2.ZERO
	for d in delta:
		sum += d
	return sum/3

static func nearst3points(src,points):
	var pts3 = []
	for pt in points:
		if pt == src:
			continue
		var lenSqr = (src.position-pt.position).length_squared()
		if len(pts3)<3:
			pts3.append({
				"pt":pt,
				"dis":lenSqr
			}
			)
		else:
			for p in pts3:
				if lenSqr<p.dis:
					pts3.erase(p)
					pts3.append({
						"pt":pt,
						"dis":lenSqr
					})
					break
	return [pts3[0].pt.position,pts3[1].pt.position,pts3[2].pt.position]

func check_in_delta(center=Vector2(0,0),delta=[]):
	if ccw(delta):
		delta.invert()
	return check_point_cw(center,delta[0],delta[1])&&check_point_cw(center,delta[1],delta[2])&&check_point_cw(center,delta[2],delta[0])

func ccw(delta = []):
	return check_point_cw(delta[2],delta[1],delta[0])

func check_point_cw(p,vec_dst,vec_src = Vector2.ZERO):
	var vA = vec_dst - vec_src
	var vB = p - vec_src
	return vA.cross(vB)>0
