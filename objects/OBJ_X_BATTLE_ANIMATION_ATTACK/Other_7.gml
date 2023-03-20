if target.HP <= 0 {
	debug("Enemy is KO");
	target.KO = true;
}
instance_destroy()