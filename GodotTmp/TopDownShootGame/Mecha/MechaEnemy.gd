extends Mecha

class_name MechaEnemy

var enemys = []

onready var oriPos = position

func _ready():
	team = 1

func ScanEnemy(distance):
	var tmp = []
	for t in $ViewRange2D.targets:
		if t is Mecha && t.team!=team:
			if (t.position - position).length_squared()<(distance*distance):
				tmp.append(t)
	enemys = tmp
	return tmp

func AttackNearstTarget():
	#print("Attack")
	var tmp = ScanEnemy(192)
	for t in tmp:
		$ShootTarget.ShootTarget(t)

func Patrol():
	var dst = oriPos + Vector2(randf(),randf())*128
	$MovementAgent.MoveTo(dst)

func MoveToNearestEnemy(distance):
	#print("Approch")
	for t in enemys:
		$MovementAgent.Approch(t,distance)
		return

func MoveAwayFromEnemy():
	#print("Flee")
	for t in enemys:
		var tPos = (position - t.position).normalized()*128
		$MovementAgent.MoveTo(tPos)
		return

func _physics_process(delta):
	for t in enemys:
		if is_instance_valid(t):
			$ShootTarget.look_at(t.position)
			return

func _on_UnitLife_dead():
	queue_free()
