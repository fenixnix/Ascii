extends Spatial

export(PackedScene) var projectile

func Shoot(target):
	var bullet = projectile.instance()
	add_child(bullet)
	bullet.Run(target)
	
